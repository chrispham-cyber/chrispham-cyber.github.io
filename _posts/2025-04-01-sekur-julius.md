---
layout: post
title:  "Sekur Julius"
date:   2025-04-01 18:30:00 -0400
categories: HTB-challenge crypto very-easy
tags: HTB CTF writeup
---

### SOLUTION
Reading source code, we can see:
- The function takes a message (msg) and a shift value (shift).
- If the character is a space, it appends '0' to the ciphertext.
- If the character is not an uppercase letter (A-Z), it appends the character as is.
- If the character is an uppercase letter, it calculates the new character by shifting it within the alphabet using the Caesar cipher logic.

Now we write decrypt code, reverse the formula:
![](/assets/img/htb/sekur julius/1.png)

We got the message!
![](/assets/img/htb/sekur julius/2.png)
