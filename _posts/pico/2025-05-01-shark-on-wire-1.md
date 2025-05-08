---
layout: post
title:  "shark on wire 1"
date:   2025-05-01 23:00:00 -0400
categories: PICO-challenge forensics medium 
tags: pico CTF writeup wireshark
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/shark-on-wire-1/1.png)

### SOLUTION 
Use `Statistics` > `Protocol Hierarchy` to analyze numbers and types of protocol.
![](assets/img/pico/shark-on-wire-1/2.png)
We can see that lots of `UDP` here, follow one of them and we can see the `stream`, which we have in the hint.
![](assets/img/pico/shark-on-wire-1/3.png)
Modify the stream until we see the flag
