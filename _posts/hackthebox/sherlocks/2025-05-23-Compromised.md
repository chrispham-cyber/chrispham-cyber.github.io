---
layout: post
title:  "Compromised"
date:   2025-05-23 23:57:00 -0400
categories: HTB-sherlock SOC easy
tags: CTF writeup wireshark
image:
    path: assets/img/htb/Compromised/banner.png
---

### CHALLENGE DESCRIPTION
Our SOC team detected suspicious activity in Network Traffic, the machine has been compromised and company information that should not have been there has now been stolen – it’s up to you to figure out what has happened and what data has been taken.

### SOLUTION 

**What is the IP address used for initial access?**

Search for `HTTP`, we will see the first packet, copy value from IP source.

<details>
<summary><b>Answer</b></summary>
162.252.172.54
</details>

**What is the SHA256 hash of the malware?**

We need to export `HTTP` and download the file.

![](assets/img/htb/Compromised/1.png)

After downloading, we need to check its status by [VirusTotal](https://virustotal.com)

<details>
<summary><b>Answer</b></summary>
9b8ffdc8ba2b2caa485cca56a82b2dcbd251f65fb30bc88f0ac3da6704e4d3c6
</details>

**What is the Family label of the malware?**

Click on `Relation` tab on VirusTotal and search for `parent`

<details>
<summary><b>Answer</b></summary>
Pikabot
</details>

**When was the malware first seen in the wild (UTC)?**
<details>
<summary><b>Answer</b></summary>
2023-05-19 14:01:21 
</details>

**The malware used HTTPS traffic with a self-signed certificate. What are the ports, from smallest to largest?**

To analyze ports, we should go to Statistics > IPv4 > Destination and Ports 

![](assets/img/htb/Compromised/2.png)

Filter `TLS`

![](assets/img/htb/Compromised/3.png)

We will see some non-default ports there.

<details>
<summary><b>Answer</b></summary>
2078, 2222, 32999
</details>

**What is the id-at-localityName of the self-signed certificate associated with the first malicious IP?**

```
tls.handshake.certificate
```

We will see `Sever Key Exchange`, analyze the first packet > Transport Layer Security > Handshake protocol > Certificates > Certificate > Issuer > id-at-localityName.

<details>
<summary><b>Answer</b></summary>
Pyopneumopericardium
</details>

**What is the notBefore time(UTC) for this self-signed certificate?**

Transport Layer Security > Handshake protocol > Certificates > Certificate > validity > notBefore

<details>
<summary><b>Answer</b></summary>
2023-05-14 08:36:52 (UTC)
</details>

**What was the domain used for tunneling?**

Search `DNS` and we will see the domain on the Info colunm.

<details>
<summary><b>Answer</b></summary>
steasteel.net
</details>
