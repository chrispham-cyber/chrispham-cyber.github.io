---
layout: post
title:  "Foggy Intrusion"
date:   2025-04-07 16:30:00 -0400
categories: HTB-challenge forensics easy
tags: HTB CTF writeup wireshark base64 
---

### SOLUTION
Open `pcap` file with `Wireshark`, search for `HTTP` and we can see some `POST` method, follow them.
![](assets/img/htb/foggy intrusion/1.png)

We can see lots of `base64` strings. What we need to do is decode all of the outputs (blue text) to find the flag.
![](assets/img/htb/foggy intrusion/2.png)

Extract all strings and decode the content using Cyberchef applying `Fork` + `From base64` + `Raw inflate` operations.
![](assets/img/htb/foggy intrusion/3.png)
