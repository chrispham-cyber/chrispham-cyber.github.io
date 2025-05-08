---
layout: post
title:  "advanced-potion-making"
date:   2025-04-29 20:50:00 -0400
categories: PICO-challenge forensics medium 
tags: pico CTF writeup steg 
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/advanced-potion-making/1.png)

### SOLUTION
First, we use `strings` to analyze the file, and we see `IHDR`, search it on Google, and we see `PNG` file. 
![](assets/img/pico/advanced-potion-making/2.png)

Using `hexeditor` to modify hex at `02 03 09 0A 0B`
![](assets/img/pico/advanced-potion-making/3.png)

But what we can see is the red picture, use `StegSolve` to change it color and we get the flag.
![](assets/img/pico/advanced-potion-making/4.png)

