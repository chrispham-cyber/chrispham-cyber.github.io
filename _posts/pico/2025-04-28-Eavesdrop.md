---
layout: post
title:  "Eavesdrop"
date:   2025-04-28 23:45:00 -0400
categories: PICO-challenge forensics medium 
tags: pico CTF writeup wireshark
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/Eavesdrop/1.png)

### SOLUTION 
We follow the conversation in the packet.
![](assets/img/pico/Eavesdrop/2.png)

We found the command to decrypt the flag, but we don't have `flag.des3`. We know that they transfer the file through port `9002`. Let follow that port.
![](assets/img/pico/Eavesdrop/3.png)

We can see the salted. Save it as `raw` and name `file.des3`. Run the command and we get the flag.
