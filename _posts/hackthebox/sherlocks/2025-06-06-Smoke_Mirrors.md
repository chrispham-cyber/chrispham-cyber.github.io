---
layout: post
title:  "Operation Blackout 2025: Smoke & Mirrors"
date:   2025-06-06 20:07:00 -0400
categories: HTB-sherlock DFIR very-easy
tags: CTF writeup log evtx
image:
    path: assets/img/htb/Smoke-Mirrors/banner.png
---

### CHALLENGE DESCRIPTION
Byte Doctor Reyes is investigating a stealthy post-breach attack where several expected security logs and Windows Defender alerts appear to be missing. He suspects the attacker employed defense evasion techniques to disable or manipulate security controls, significantly complicating detection efforts. Using the exported event logs, your objective is to uncover how the attacker compromised the system's defenses to remain undetected.

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

**The attacker disabled LSA protection on the compromised host by modifying a registry key. What is the full path of that registry key?**
```bash
grep -i lsa *
```

<details>
<summary><b>Answer</b></summary>
HKLM\SYSTEM\CurrentControlSet\Control\LSA
</details>

**Which PowerShell command did the attacker first execute to disable Windows Defender?**

```bash
grep 'Set-MpPreference' *
```

<details>
<summary><b>Answer</b></summary>
Set-MpPreference -DisableIOAVProtection $true -DisableEmailScanning $true -DisableBlockAtFirstSeen $true
</details>

**The attacker loaded an AMSI patch written in PowerShell. Which function in the DLL is being patched by the script to effectively disable AMSI?**

Search `hunt for AMSI bypasses in PowerShell logs`

```bash
egrep -i 'AmsiScanBuffer|VirtualProtect|LoadLibrary|GetProcAddress' * 
```

<details>
<summary><b>Answer</b></summary>
AmsiScanBuffer
</details>

**Which command did the attacker use to restart the machine in Safe Mode?**
Search `command used to restart machine in safe mode` on Google


```bash
grep -i '/set safeboot' *
```

<details>
<summary><b>Answer</b></summary>
bcdedit.exe /set safeboot network
</details>

**Which PowerShell command did the attacker use to disable PowerShell command history logging?**
```bash
grep -i 'history' *  
```

<details>
<summary><b>Answer</b></summary>
Set-PSReadlineOption -HistorySaveStyle SaveNothing
</details>

