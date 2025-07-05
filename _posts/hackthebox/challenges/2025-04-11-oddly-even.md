---
layout: post
title:  "Oddly Even"
date:   2025-04-11 16:10:00 -0400
categories: HTB-challenge coding very-easy
tags: HTB CTF writeup 
---

### DESCRIPTION
Take in a number, print "odd" if odd and "even" if even.
Example
```
Input: 3
Output: odd 
```

### SOLUTION
```python
n = int(input())
print("odd" if n % 2 != 0 else "even")
```
