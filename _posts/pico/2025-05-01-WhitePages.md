---
layout: post
title:  "WhitePages"
date:   2025-05-01 22:05:00 -0400
categories: PICO-challenge forensics medium 
tags: pico CTF writeup 
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/WhitePages/1.png)

### SOLUTION 
We try to see the file, but there is something inside but we can not see.
![](assets/img/pico/WhitePages/2.png)

We search for space character ` ` in the file, and we see that it's not only space, but something like tab and more.

So the idea is replace space with `1` and tab with `0`

```python
with open('whitepages.txt', 'r') as file:
    content = file.read()

converted = ''.join(['1' if char == ' ' else '0' for char in content])

print(converted)
```

We get binary string, decode it.
![](assets/img/pico/WhitePages/3.png)
