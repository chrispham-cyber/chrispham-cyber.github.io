---
layout: post
title:  "Operation Oni"
date:   2025-04-28 23:25:00 -0400
categories: PICO-challenge forensics medium 
tags: pico CTF writeup autopsy
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/Operation-Oni/1.png)

### SOLUTION 
We need to use `autopsy` to analyze disk
```bash
sudo autopsy
```
We have `id-key` to bypass `ssh`
![](assets/img/pico/Operation-Oni/2.png)

```bash
ssh -i key -p 64171 ctf-player@saturn.picoctf.net
```
