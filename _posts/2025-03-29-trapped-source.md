---
layout: post
title:  "Trapped Source"
date:   2025-03-29 10:30:00 -0400
categories: HTB-challenge web very-easy
tags: HTB CTF writeup
---

### SOLUTION
Go to the website, we can see that it requires us to input pin code. Inspect the web, we know the correct pin is `9001`. But we don't have `0` button.
![](assets/img/htb/trapped source/1.png)
Go to the `script`, we can see the data type is `json` and directory is `/flag` and web's method `POST`
![](assets/img/htb/trapped source/2.png)
Using `BurpSuite` to change something and we got the flag.
![](assets/img/htb/trapped source/3.png)
