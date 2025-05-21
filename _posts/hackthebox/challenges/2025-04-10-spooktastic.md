---
layout: post
title:  "SpookTastic"
date:   2025-04-10 14:20:00 -0400
categories: HTB-challenge web very-easy
tags: HTB CTF writeup XSS 
---

### SOLUTION
By analyzing the source code, we can see the black list
```
def blacklist_pass(email):
    email = email.lower()

    if "script" in email:
        return False

    return True


def send_flag(user_ip):
    for id, ip in socket_clients.items():
        if ip == user_ip:
            socketio.emit("flag", {"flag": open("flag.txt").read()}, room=id)

```

we can not use `<script>` for XSS payload, how about `<img>`

```js
<img src=x onerror=alert(2)>
```
