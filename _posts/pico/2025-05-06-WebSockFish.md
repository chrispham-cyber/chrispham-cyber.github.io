---
layout: post
title:  "WebSockFish"
date:   2025-05-06 23:55:00 -0400
categories: PICO-challenge web medium 
tags: pico CTF writeup 
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/WebSockFish/1.png)

### SOLUTION 
Using "BurpSuite" to intercept the web, and we can see that when that bot moves, it send the `eval` to us, let change it.
![](assets/img/pico/WebSockFish/2.png)
