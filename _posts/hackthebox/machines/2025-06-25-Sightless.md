---
layout: post
title:  "Sightless"
date:   2025-06-25 22:00:00 -0400
categories: HTB-machine linux easy 
tags: HTB CTF writeup 
image:
    path: assets/img/htb/Sightless/Sightless.png
---

# Machine Information

 `Sightless` is an easy-difficulty Linux machine featuring a website for a company offering various services. Enumeration of the website reveals an `SQLPad` instance vulnerable to template injection `[CVE-2022-0944](https://nvd.nist.gov/vuln/detail/CVE-2022-0944)`, which is leveraged to gain a foothold inside a Docker container. Further enumeration reveals the `/etc/shadow` file with a password hash, which is cracked to reveal the password, granting `SSH` access to the host. Post-exploitation enumeration reveals a `Froxlor` instance vulnerable to Blind `XSS` `[CVE-2024-34070](https://nvd.nist.gov/vuln/detail/CVE-2024-34070)`. This is leveraged to gain access to the `FTP` service, which contains a `KeePass` database. Accessing the database reveals the root `SSH` keys, leading to a privileged shell on the host. 

# Writeup
### Enumeration
```bash
nmap -sCV 10.129.231.103     
                                                                                                                    
PORT   STATE SERVICE VERSION                                                                                                                               
21/tcp open  ftp                                                                                                                                           
| fingerprint-strings:                                                                                                                                     
|   GenericLines:                                                                                                                                          
|     220 ProFTPD Server (sightless.htb FTP Server) [::ffff:10.129.231.103]                                                                                
|     Invalid command: try being more creative                                                                                                             
|_    Invalid command: try being more creative                                                                                                             
22/tcp open  ssh     OpenSSH 8.9p1 Ubuntu 3ubuntu0.10 (Ubuntu Linux; protocol 2.0)                                                                         
| ssh-hostkey:                                                                                                                                             
|   256 c9:6e:3b:8f:c6:03:29:05:e5:a0:ca:00:90:c9:5c:52 (ECDSA)                                                                                            
|_  256 9b:de:3a:27:77:3b:1b:e1:19:5f:16:11:be:70:e0:56 (ED25519)                                                                                          
80/tcp open  http    nginx 1.18.0 (Ubuntu)                                                                                                                 
|_http-title: Did not follow redirect to http://sightless.htb/                                                                                             
|_http-server-header: nginx/1.18.0 (Ubuntu)                                                                                                                
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :                                                                                                                                          
SF-Port21-TCP:V=7.94SVN%I=7%D=6/25%Time=685CA170%P=x86_64-pc-linux-gnu%r(G                                                                                 
SF:enericLines,A3,"220\x20ProFTPD\x20Server\x20\(sightless\.htb\x20FTP\x20                                                                                 
SF:Server\)\x20\[::ffff:10\.129\.231\.103\]\r\n500\x20Invalid\x20command:\                                                                                 
SF:x20try\x20being\x20more\x20creative\r\n500\x20Invalid\x20command:\x20tr                                                                                 
SF:y\x20being\x20more\x20creative\r\n");                                                                                                                   
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel 
```

We need to resolve DNS
```bash
echo '10.129.231.103 sightless.htb' | sudo tee -a /etc/hosts     
                                                                                
10.129.231.103 sightless.htb
```

Browse the web manually, we will find subdomain. We can see its version in `About` tab in subdomain. Clone CVE and exlpoit the machine.
```bash
git clone https://github.com/0xRoqeeb/sqlpad-rce-exploit-CVE-2022-0944.git 
```

### User Flag
After exploiting, we will get the hash of `Michael`, crack it and access through `SSH`. Get the user's flag.
