---
layout: post
title:  "TwoMillion"
date:   2025-03-22 18:30:00 -0400
categories: HTB-machine linux easy
tags: HTB CTF writeup 
image:
    path: assets/img/htb/twomillion/banner.png
---

# Writeup
After scanning, we know how many ports are openned.
![](assets/img/htb/twomillion/scan.png)

After accessing IP, it redirects us to this domain.
![](assets/img/htb/twomillion/redirect.png)

Resolve domain
![](assets/img/htb/twomillion/resolve.png)

Go to `/invite` page, `F12` to see inspect the code, change to tab `Network` and reload. We can see the JS files here.
![](assets/img/htb/twomillion/invite.png)

Unpack the JS code, read the code and we will see which function hints about how to get an invite code.
![](assets/img/htb/twomillion/unpack.png)

Decrypt and get invite code.
![](assets/img/htb/twomillion/decrypt.png)
![](assets/img/htb/twomillion/code.png)

Using `BurpSuite` to check out endpoints that might return a list of endpoints.
![](./img/htb/twonillion/api.png)

After checking endpoints, we can change the role of our account and inject vulnerable command to `/api/v1/admin/vpn/generate`
![](assets/img/htb/twomillion/update.png)
![](assets/img/htb/twomillion/inject.png)

After sending, we can get the shell
![](assets/img/htb/twomillion/shell.png)

List all files, we can see the hidden file `env`, view the content we can get the password of admin's account. Change to `Admin` user and get flag.

![](assets/img/htb/twomillion/admin.png)
![](assets/img/htb/twomillion/flag.png)

Mail on Linux system is typically stored in one of a few locations.
![](assetes/img/htb/twomillion/mail.png)

Search `CVE OverlayFS / FUSE` on Google, and we will get the payload file. Download and exploit.
![](assets/img/htb/twomillion/root.png)

Ref: [CVE-2023-0386](https://github.com/xkaneiki/CVE-2023-0386)
