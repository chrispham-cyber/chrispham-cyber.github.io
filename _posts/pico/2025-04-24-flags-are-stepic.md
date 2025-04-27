---
layout: post
title:  "flags are stepic"
date:   2025-04-24 23:59:00 -0400
categories: PICO-challenge forensics medium 
tags: pico CTF writeup img steg 
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/flags-are-stepic/1.png)

### SOLUTION
We can view the source code of the web, we notice that the file's name of the flags in `xx.png` format, but only 1 with `xxx.png`
![](assets/img/pico/flags-are-stepic/2.png)

Download it and try to analyze with `exiftool, strings, binwalk, zsteg, stegsolve` but nothing useful here.

Look at the name of challenge, we can see `stepic`, do some research about it
![](assets/img/pico/flags-are-stepic/3.png)

So `stepic` is actually a tool to analyze just like `zsteg, stegsolve...`
```bash
stepic -d -i [file]
```
