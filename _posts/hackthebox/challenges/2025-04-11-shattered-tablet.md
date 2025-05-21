---
layout: post
title:  "Shattered Tablet"
date:   2025-04-11 14:10:00 -0400
categories: HTB-challenge reversing very-easy
tags: HTB CTF writeup 
---

### SOLUTION
Using `BinaryNinja` to analyze the code, we can see the `main` function here.
![](assets/img/htb/shattered tablet/1.png)

What we need to do is convert the `hex` to `decimal` and get the flag.
![](assets/img/htb/shattered tablet/2.png)
