---
layout: post
title:  "Wrong Spooky Season"
date:   2025-04-07 15:50:00 -0400
categories: HTB-challenge forensics very-easy
tags: HTB CTF writeup wireshark base64 
---

### SOLUTION
Using `Wireshark` to analyze the network. Search for `HTTP` protocol.
![](assets/img/htb/wrong spooky season/1.png)

We can see there is a `Upload File Vulnerability` here
![](assets/img/htb/wrong spooky season/2.png)

Follow IP with port `1337` and we get the `Base64` string in reverse.
![](assets/img/htb/wrong spooky season/3.png)
