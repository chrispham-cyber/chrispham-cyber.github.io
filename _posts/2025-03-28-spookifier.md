---
layout: post
title:  "Spookifier"
date:   2025-03-28 18:30:00 -0400
categories: HTB-challenge web very-easy
tags: HTB CTF writeup
---

### SOLUTION
Firstly, we try XSS to the search bar: `<script>alert(1)</script>`
![](assets/img/htb/spookifier/1.png)

We can see that it responses. But XSS is used for manipulating the user experience, and there is no user here. So we should another payload (SSTI): `${{7*'7'}}`
![](assets/img/htb/spookifier/2.png)

We can see it returns `7777777`, so it is a `JINJA2` type, let try this: `${self.module.cache.util.os.popen('whoami').read()}`
![](assets/img/htb/spookifier/3.png)

We are `root` now, so let find the flag.
![](assets/img/htb/spookifier/4.png)
