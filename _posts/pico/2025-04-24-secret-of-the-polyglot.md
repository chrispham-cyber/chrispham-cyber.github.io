---
layout: post
title:  "Secret of the Polyglot"
date:   2025-04-24 23:55:00 -0400
categories: PICO-challenge forensics easy
tags: pico CTF writeup pdf 
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/secret-of-the-polyglot/1.png)

### SOLUTION
First, we can see half of the flag in the `PDF` file
![](assets/img/pico/secret-of-the-polyglot/2.png)

We can try something like `strings` or `binwalk` but nothing is interesting
![](assets/img/pico/secret-of-the-polyglot/3.png)

Let try `exiftool` and we can notice the type of file is `PNG` while the file's extension is `PDF`, so change pdf to png and we got the flag.
![](assets/img/pico/secret-of-the-polyglot/4.png)
