---
layout: post
title:  "SmartyPants"
date:   2025-06-03 12:07:00 -0400
categories: HTB-sherlock DFIR very-easy
tags: CTF writeup log evtx
image:
    path: assets/img/htb/SmartyPants/banner.png
---

### CHALLENGE DESCRIPTION
Forela's CTO, Dutch, stores important files on a separate Windows system because the domain environment at Forela is frequently breached due to its exposure across various industries. On 24 January 2025, our worst fears were realised when an intruder accessed the fileserver, installed utilities to aid their actions, stole critical files, and then deleted them, rendering them unrecoverable. The team was immediately informed of the extortion attempt by the intruders, who are now demanding money. While our legal team addresses the situation, we must quickly perform triage to assess the incident's extent. Note from the manager: We enabled SmartScreen Debug Logs across all our machines for enhanced visibility a few days ago, following a security research recommendation. These logs can provide quick insights, so ensure they are utilised.

### SET UP
```bash
# 1. Create a Python virtual environment
python3 -m venv myenv

# 2. Activate the virtual environment
source myenv/bin/activate   # For Linux/macOS

# 3. Install the python-evtx library
pip install python-evtx

# 4. Download the evtx_dump.py script 
wget https://raw.githubusercontent.com/williballenthin/python-evtx/master/scripts/evtx_dump.py

# 5. Run the script on your .evtx file
python3 evtx_dump.py some.evtx > log.xml
```

### SOLUTION 

After unzipping the file, we see lots of `evtx` files.

**The attacker logged in to the machine where Dutch saves critical files, via RDP on 24th January 2025. Please determine the timestamp of this login.**
> **Hint:** Use Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational Log and filter for event id 1149

We will use [this](https://raw.githubusercontent.com/williballenthin/python-evtx/refs/heads/master/scripts/evtx_dump.py) to dump all evtx files and analyze them.
```bash
python3 -m venv myenv
source myenv/bin/activate
pip install python-evtx
python3 evtx_dump.py [filename].evtx > log
```

```bash
grep -a10 1149 log
```

<details>
<summary><b>Answer</b></summary>
2025-01-24 10:15:14
</details>

**The attacker downloaded a few utilities that aided them for their sabotage and extortion operation. What was the first tool they downloaded and installed?**
> **Hint:** Use Smartscreen Debug Log

```bash
grep .exe log
```

Oh wow, It shows lots of trash info, let filter it out, we can see executionTime
```bash
grep -i executionTime log
```

Feel better now, now lool at the output, what is the first tool attacker downloaded? 

<details>
<summary><b>Answer</b></summary>
WinRAR
</details>

**They then proceeded to download and then execute the portable version of a tool that could be used to search for files on the machine quickly and efficiently. What was the full path of the executable?**

We have same hint from above.

Look below the first downloaded tool, copy the path and delete the backslash.

<details>
<summary><b>Answer</b></summary>
C:\Users\Dutch\Downloads\Everything.exe
</details>

**What is the execution time of the tool from task 3?**

Same hint

We need to see around that line.

<details>
<summary><b>Answer</b></summary>
2025-01-24 10:17:33
</details>

**The utility was used to search for critical and confidential documents stored on the host, which the attacker could steal and extort the victim. What was the first document that the attacker got their hands on and breached the confidentiality of that document?**

```
grep -i document log
```

copy the path and delete backsplash.

<details>
<summary><b>Answer</b></summary>
C:\Users\Dutch\Documents\2025- Board of directors Documents\Ministry Of Defense Audit.pdf
</details>

**Find the name and path of second stolen document as well.**
<details>
<summary><b>Answer</b></summary>
C:\Users\Dutch\Documents\2025- Board of directors Documents\2025-BUDGET-ALLOCATION-CONFIDENTIAL.pdf
</details>

**The attacker installed a Cloud utility as well to steal and exfiltrate the documents. What is name of the cloud utility?**

```bash
grep -i executionTime log
```

We will see something like `sync` short for synchrony.

<details>
<summary><b>Answer</b></summary>
MEGAsync
</details>

**When was this utility executed?**
<details>
<summary><b>Answer</b></summary>
2025-01-24 10:22:19
</details>

**The Attacker also proceeded to destroy the data on the host so it is unrecoverable. What utility was used to achieve this?**
<details>
<summary><b>Answer</b></summary>
File Shredder
</details>

**The attacker cleared 2 important logs, thinking they covered all their tracks. When was the security log cleared?**

> **Hint:** Filter for event id 1102 in security log

Convert Security.evtx to log then filter 1102.

<details>
<summary><b>Answer</b></summary>
2025-01-24 10:28:41    
</details>

