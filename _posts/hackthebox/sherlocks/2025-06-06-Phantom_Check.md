---
layout: post
title:  "Operation Blackout 2025: Phantom Check"
date:   2025-06-06 22:07:00 -0400
categories: HTB-sherlock DFIR very-easy
tags: CTF writeup log evtx
image:
    path: assets/img/htb/Phantom-Check/banner.png
---

### CHALLENGE DESCRIPTION
Talion suspects that the threat actor carried out anti-virtualization checks to avoid detection in sandboxed environments. Your task is to analyze the event logs and identify the specific techniques used for virtualization detection. Byte Doctor requires evidence of the registry checks or processes the attacker executed to perform these checks.

### SOLUTION 

After unzipping the file, we see lots of `evtx` files.

**Which WMI class did the attacker use to retrieve model and manufacturer information for virtualization detection?**

Search `WMI class use to retrieve model and manufacturer information for virtualization detection` on Google 

<details>
<summary><b>Answer</b></summary>
Win32_ComputerSystem
</details>

**Which WMI query did the attacker execute to retrieve the current temperature value of the machine?**

Search `WMI query to retrieve the current temperature value of the machine` on Google

We got `MSAcpi_ThermalZoneTemperature`

```bash
grep -a3 -i 'MSAcpi_ThermalZoneTemperature' *
```

<details>
<summary><b>Answer</b></summary>
SELECT * FROM MSAcpi_ThermalZoneTemperature
</details>

**The attacker loaded a PowerShell script to detect virtualization. What is the function name of the script?**
<details>
<summary><b>Answer</b></summary>
Check-VM
</details>

**Which registry key did the above script query to retrieve service details for virtualization detection?**

```bash
grep -a50 -i 'Check-VM' *
```

<details>
<summary><b>Answer</b></summary>
HKLM:\SYSTEM\ControlSet001\Services
</details>

**The VM detection script can also identify VirtualBox. Which processes is it comparing to determine if the system is running VirtualBox?**

Search `Processes Checked for VirtualBox Detection` on Google

```bash
grep -i 'VBox' *
```

<details>
<summary><b>Answer</b></summary>
vboxservice.exe, vboxtray.exe
</details>

**The VM detection script prints any detection with the prefix 'This is a'. Which two virtualization platforms did the script detect?**

```bash
grep 'This is a' *
```

<details>
<summary><b>Answer</b></summary>
Hyper-V, Vmware
</details>

