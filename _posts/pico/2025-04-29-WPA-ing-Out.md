---
layout: post
title:  "WPA-ing Out"
date:   2025-04-29 20:20:00 -0400
categories: PICO-challenge forensics medium 
tags: pico CTF writeup wireshark aircrack 
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/WPA-ing-Out/1.png)

### SOLUTION 
As we can see in the hint, we will use `aircrack` to crack the password
```bash
aircrack-ng wpa-ing_out.pcap -w rockyou.txt
```
