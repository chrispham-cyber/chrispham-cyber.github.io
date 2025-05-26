---
layout: post
title:  "SQL Direct"
date:   2025-05-09 23:50:00 -0400
categories: PICO-challenge web medium 
tags: pico CTF writeup postgre 
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/SQL-Direct/1.png)

### SOLUTION 
```bash
psql -h saturn.picoctf.net -p 55291 -U postgres pico #to connect to server.

{Back splash} l #to show all databases

{Back splash} dt #to show all tables

select * from ...; #to get the flag
```
