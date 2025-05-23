---
layout: post
title:  "Constellation"
date:   2025-05-23 12:07:00 -0400
categories: HTB-sherlock threat-intelligence medium 
tags: CTF writeup url Constellation
image:
    path: assets/img/htb/Constellation/banner.png
---

### CHALLENGE DESCRIPTION
The SOC team has recently been alerted to the potential existence of an insider threat. The suspect employee's workstation has been secured and examined. During the memory analysis, the Senior DFIR Analyst succeeded in extracting several intriguing URLs from the memory. These are now provided to you for further analysis to uncover any evidence, such as indications of data exfiltration or contact with malicious entities. Should you discover any information regarding the attacking group or individuals involved, you will collaborate closely with the threat intelligence team. Additionally, you will assist the Forensics team in creating a timeline. Warning : This Sherlock will require an element of OSINT and some answers can be found outside of the provided artifacts to complete fully.

### SOLUTION 

**When did the suspect first start Direct Message (DM) conversations with the external entity (A possible threat actor group which targets organizations by paying employees to leak sensitive data)? (UTC)**

Let try `exiftool` on both files, try to input the date we have. But nothing happed.

So I serach on Google and find out that there is a `URL forensic` called [Unfurl](https://dfir.blog/unfurl/)

So we have 2 links in `IOC.txt`, let analyze them. Copy and paste first link

<details>
<summary><b>Answer</b></summary>
2023-09-16 16:03:37
</details>

**What was the name of the file sent to the suspected insider threat?**
<details>
<summary><b>Answer</b></summary>
NDA_Instructions.pdf
</details>

**When was the file sent to the suspected insider threat? (UTC)**
<details>
<summary><b>Answer</b></summary>
2023-09-27 05:27:02
</details>

**The suspect utilised Google to search something after receiving the file. What was the search query?**
<details>
<summary><b>Answer</b></summary>
how to zip a folder using tar in linux
</details>

**The suspect originally typed something else in search tab, but found a Google search result suggestion which they clicked on. Can you confirm which words were written in search bar by the suspect originally?**
<details>
<summary><b>Answer</b></summary>

</details>

**When was this Google search made? (UTC)**

Copy and paste second link

<details>
<summary><b>Answer</b></summary>
2023-09-27 05:31:45
</details>

**What is the name of the Hacker group responsible for bribing the insider threat?**

Open `pdf` file

<details>
<summary><b>Answer</b></summary>
AntiCorp Gr04p
</details>

**What is the name of the person suspected of being an Insider Threat?**
<details>
<summary><b>Answer</b></summary>
Karen Riley
</details>

**What is the anomalous stated creation date of the file sent to the insider threat? (UTC)**

Using `exiftool`
```bash
exiftool NDA_Instructions.pdf
```

``` 
ExifTool Version Number         : 13.10
File Name                       : NDA_Instructions.pdf
Directory                       : .
File Size                       : 26 kB
File Modification Date/Time     : 2024:03:05 05:02:19-05:00
File Access Date/Time           : 2025:05:23 11:46:39-04:00
File Inode Change Date/Time     : 2025:05:23 11:44:16-04:00
File Permissions                : -rw-rw-r--
File Type                       : PDF
File Type Extension             : pdf
MIME Type                       : application/pdf
PDF Version                     : 1.7
Linearized                      : No
Page Count                      : 1
Producer                        : AntiCorp PDF FW
Create Date                     : 2054:01:17 22:45:22+01:00
Title                           : KarenForela_Instructions
Author                          : CyberJunkie@AntiCorp.Gr04p
Creator                         : AntiCorp
Modify Date                     : 2054:01:17 22:45:22+01:00
Subject                         : Forela_Mining stats and data campaign (Stop destroying env)
```

We will see `Create Date` field, but it is +01:00, so minus to get flag.

<details>
<summary><b>Answer</b></summary>
2054-01-17 21:45:22
</details>

**The Forela threat intel team are working on uncovering this incident. Any OpSec mistakes made by the attackers are crucial for Forela's security team. Try to help the TI team and confirm the real name of the agent/handler from Anticorp.**

Search `AntiCorp Gr04p` on Google and we will get the flag for 2 last questions.
<details>
<summary><b>Answer</b></summary>
Abdullah Al Sajjad
</details>

**Which City does the threat actor belong to?**
<details>
<summary><b>Answer</b></summary>
Bahawalpur
</details>

