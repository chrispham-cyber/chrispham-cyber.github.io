---
layout: post
title:  "Red Miners"
date:   2025-04-07 12:40:00 -0400
categories: HTB-challenge forensics very-easy
tags: HTB CTF writeup 
---

### SOLUTION
View the file's content we can see 4 encoding with `Base64`. They are in 3 functions below:
- `check_if_operation_is_active()`
- `checkExists()`
- 2 in `download()`
