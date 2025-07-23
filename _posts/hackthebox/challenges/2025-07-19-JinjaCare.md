---
layout: post
title:  "JinjaCare"
date:   2025-07-19 17:10:00 -0400
categories: HTB-challenge very-easy
tags: HTB CTF writeup web
---

### Solutions
As you can see the title of the challenge, we will notice that this challenge is about `SSTI`, so let try `${7*'7'}}` in any input form.

But first, we need to register account.
![](assets/img/htb/JinjaCare/1.png)

In `Personal Info`, we change `Full Name` and save it.
![](assets/img/htb/JinjaCare/2.png)

Now we download the certificate, and see the result.
![](assets/img/htb/JinjaCare/3.png)

As we can see, it works. Now use this payload: `{request.application.__globals__.__builtins__.__import__('os').popen('ls /').read()}}`
