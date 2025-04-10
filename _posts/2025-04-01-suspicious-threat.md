---
layout: post
title:  "Suspicious Threat"
date:   2025-04-01 22:30:00 -0400
categories: HTB-challenge forensics easy
tags: HTB CTF writeup library 
---

### CHALLENGE DESCRIPTION
Our `SSH server` is showing strange `library linking errors`, and critical folders seem to be missing despite their confirmed existence. Investigate the anomalies in the library loading process and filesystem. Look for hidden manipulations that could indicate a userland rootkit. Creds: `root:hackthebox`

### SOLUTION
Access to SSH
![](assets/img/htb/suspicious threat/1.png)

Use the `ldd` command to inspect which libraries the SSH server executable depends on.
![](assets/img/htb/suspicious threat/2.png)

Searching for `flag`
![](assets/img/htb/suspicious threat/3.png)
