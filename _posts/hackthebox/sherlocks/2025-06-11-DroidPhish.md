---
layout: post
title:  "DroidPhish"
date:   2025-06-11  01:07:00 -0400
categories: HTB-sherlock DFIR easy
tags: CTF writeup disk autopsy 
image:
    path: assets/img/htb/DroidPhish/banner.png
---

### CHALLENGE DESCRIPTION
Last night, most employees' mobile devices were compromised, putting them at significant risk of leaking personal and private information. We require your expertise in digital forensics to help investigate this breach.

### SOLUTION 

**Provide the last boot time of the device in UTC format.**

Using `Autopsy` to analyze this disk, on the left, search `boottime` in File Name Search, we will see the time last changed, but it is EST, we need to change to UTC, click on ASCII String.

![](assets/img/htb/DroidPhish/1.png)

<details>
<summary><b>Answer</b></summary>
2024-11-24 12:05:19
</details>

**The user was exposed to a phishing attack. Provide the name of the email app used as the attack vector.**

Search `mail`

<details>
<summary><b>Answer</b></summary>
Proton Mail
</details>

**Provide the title of the phishing email.**

Look at `size` column, we will see the largest number, click on that file, find `title` or `subject`.

<details>
<summary><b>Answer</b></summary>
Celebrating 3 Years of Success – Thank You!
</details>

**Provide the time in UTC when the phishing email was received.**

we will see the `Date` is 2024-11-24 18:04:42 +0100, so we need to minus 1.

<details>
<summary><b>Answer</b></summary>
2024-11-24 17:04:42
</details>

**Provide the download URL for the malicious application.**

Search `download`, look for one of the largest file. Find `https`

<details>
<summary><b>Answer</b></summary>
https://provincial-consecutive-lbs-boots.trycloudflare.com/Booking.apk
</details>

**Provide the SHA-256 hash of the malicious application.**

Search filename on `hybrid-analysis`

<details>
<summary><b>Answer</b></summary>
af081cd26474a6071cde7c6d5bd971e61302fb495abcf317b4a7016bdb98eae2
</details>

**Provide the package name of the malicious application.**
<details>
<summary><b>Answer</b></summary>
com.hostel.mount 
</details>

**Provide the installation timestamp for the malicious application in UTC.**

Search `Booking.apk` in File Name Search

<details>
<summary><b>Answer</b></summary>
2024-11-24 17:14:34
</details>

**Provide the number of runtime permissions granted to the malicious application.**

On VirusTotal, `Detail` tab, find `permission` and count only red warning.

<details>
<summary><b>Answer</b></summary>
13
</details>

**Identify the C2 IP address and port that the malicious application was programmed to connect to.**
<details>
<summary><b>Answer</b></summary>
3.121.139.82:10824
</details>

