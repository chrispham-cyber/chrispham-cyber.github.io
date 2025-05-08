---
layout: post
title:  "No Sql Injection"
date:   2025-05-07 23:55:00 -0400
categories: PICO-challenge web medium 
tags: pico CTF writeup sql-injection
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/No-Sql-Injection/1.png)

### SOLUTION 
Analyze the files they gave us, and look into the `server.js`
![](assets/img/pico/No-Sql-Injection/2.png)

We can see that they use `MongoDB` and `Json`, search it and we have the payload for `nosql`.
![](assets/img/pico/No-Sql-Injection/3.png)

