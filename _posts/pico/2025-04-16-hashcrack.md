---
layout: post
title:  "hashcrack"
date:   2025-04-16 16:20:00 -0400
categories: PICO-challenge crypto easy
tags: pico CTF writeup 
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/hashcrack/1.png)

### SOLUTION
We are provided `nc verbal-sleep.picoctf.net 57819` to connect to the server.

What we need to do is:
- Use `hashid` to indentify the hash type.
- Use `hashcat -h | grep [Hash Type]` to find Hash option
- Use `hashcat -m [option] [hash] [wordlist]` to crack hash
