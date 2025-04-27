---
layout: post
title:  "OnlyHacks"
date:   2025-02-15 22:30:00 -0400
categories: HTB-challenge web very-easy
tags: HTB CTF writeup IDOR 
---

### CHALLENGE DESCRIPTION
Dating and matching can be exciting especially during Valentine's, but it’s important to stay vigilant for impostors. Can you help identify possible frauds?

### SOLUTION
At first, we can see the login page. After trying some SQL injection and nothing happen, I go to `Register` page
![](assets/img/htb/onlyhacks/login.png)
Register your account, *Note*: upload profile picture.
![](assets/img/htb/onlyhacks/register.png)
After having your account, we will match all of them and go to match page.
![](assets/img/htb/onlyhacks/match.png)
Click on `Renata` chatbox to see her `rid`
![](assets/img/htb/onlyhacks/chat.png)
Change `rid` value to get the flag! 

Good luck!
![](assets/img/htb/onlyhacks/flag.png)

