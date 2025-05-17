---
layout: post
title:  "ElectricBreeze-1"
date:   2025-05-16 23:07:00 -0400
categories: HTB-sherlock threat-intelligence very-easy
tags: CTF writeup APT TTP ATT&CK 
image:
    path: assets/img/htb/ElectricBreeze-1/banner.png
---

### CHALLENGE DESCRIPTION
Your security team must always be up-to-date and aware of the threats targeting organizations in your industry. As you begin your journey as a Threat Intelligence Intern, equipped with some SOC experience, your manager has assigned you a task to test your research skills and how effectively you can leverage the `MITRE ATT&CK` framework. * Conduct thorough research on `Volt Typhoon`. * Use the MITRE ATT&CK framework to map adversary behavior and tactics into actionable insights. Impress your manager with your assessment, showcasing your passion for threat intelligence.

### SOLUTION 

**Based on MITRE's sources, since when has Volt Typhoon been active?**

We go to [MITRE ATT&CK](https://attack.mitre.org/campaigns/) and search for `Volt Typhoon`, and click on it
 
<details>
<summary><b>Answer</b></summary>
2021
</details>

**MITRE identifies two OS credential dumping techniques used by Volt Typhoon. One is LSASS Memory access (T1003.001). What is the Attack ID for the other technique?**

Search for `T1003.001`

<details>
<summary><b>Answer</b></summary>
T1003.003
</details>

**Which database is targeted by the credential dumping technique mentioned earlier?**

Click on the link earlier. Search for `database`

<details>
<summary><b>Answer</b></summary>
Active Directory
</details>

**Which registry hive is required by the threat actor to decrypt the targeted database?**

Search for `registry`

<details>
<summary><b>Answer</b></summary>
SYSTEM
</details>

**During the June 2024 campaign, an adversary was observed using a Zero-Day Exploitation targeting Versa Director. What is the name of the Software/Malware that was used?**

Search for `Versa Director`, click on it, scroll down to `Software` section.

<details>
<summary><b>Answer</b></summary>
VersaMem
</details>

**According to the Server Software Component, what type of malware was observed?**
<details>
<summary><b>Answer</b></summary>
Web Shell
</details>

**Where did the malware store captured credentials?**

Click on `Versa` link, search for `Credential`

<details>
<summary><b>Answer</b></summary>
/tmp/.temp.data
</details>

**According to MITRE’s reference, a Lumen/Black Lotus Labs article(Taking The Crossroads: The Versa Director Zero-Day Exploitaiton.), what was the filename of the first malware version scanned on VirusTotal?**

At the bottom or search `Lotus`, we will see the link. Read the article and we will get the answer

<details>
<summary><b>Answer</b></summary>
VersaTest.png
</details>

**What is the SHA256 hash of the file?**

Search for `SHA`

<details>
<summary><b>Answer</b></summary>
4bcedac20a75e8f8833f4725adfc87577c32990c3783bf6c743f14599a176c37
</details>

**According to VirusTotal, what is the file type of the malware?**

Go to `VirusTotal` and paste the hash to the search bar.

<details>
<summary><b>Answer</b></summary>
JAR
</details>

**What is the 'Created by' value in the file's Manifest according to VirusTotal?**

Click on `Detail` tab.

<details>
<summary><b>Answer</b></summary>
Apache Maven 3.6.0
</details>

**What is the CVE identifier associated with this malware and vulnerability?**
<details>
<summary><b>Answer</b></summary>
CVE-2024-39717
</details>

**According to the CISA document [CISA](https://www.cisa.gov/sites/default/files/2024-03/aa24-038a_csa_prc_state_sponsored_actors_compromise_us_critical_infrastructure_3.pdf) referenced by MITRE, what is the primary strategy Volt Typhoon uses for defense evasion?**

Go to the link they provided, search for `defense evasion`

<details>
<summary><b>Answer</b></summary>
LOTL
</details>

**In the CISA document, which file name is associated with the command potentially used to analyze logon patterns by Volt Typhoon?**

Read from that

<details>
<summary><b>Answer</b></summary>
C:\users\public\documents\user.dat
</details>

