---
# the default layout is 'page'
icon: fas fa-file-alt
order: 4
---

# Resume

## Education

**University of Central Florida**, Orlando, FL

B.S. in Computer Science, January 2026 to September 2029 (expected)

**Miami Dade College**

A.S. in Cybersecurity

---

## Experience

**Email Spam Analyst** (contract, Upwork, remote), November 2026 to now

- Review customer spam reports for a small email service provider
- Check SPF, DKIM and DMARC in MXToolbox, find the IP the email was sent from, and look it up on blocklists
- Find the sending provider and its abuse contact from the IP owner and PTR record
- Log each case using the client's written procedure and recommend whether to escalate it or close it

**WordPress Developer**, 2021 to 2022

- Built and maintained WordPress websites with page-builder templates
- Set up themes and plugins and did routine updates

---

## Projects

**Home SOC Lab** ([GitHub](https://github.com/chrispham-cyber/home-soc-lab))

- Set up Wazuh, a Windows 11 endpoint with Sysmon, and a Kali attacker on three ARM64 VMs
- Ran attacks from Kali (brute force, encoded PowerShell, certutil download, discovery commands, nmap scan) and mapped the alerts to MITRE ATT&CK
- The default rules did not catch `whoami.exe`, so I wrote a custom Wazuh rule for it
- The nmap scan was not detected at first because the lab only had host logs. I added Suricata to get network alerts.

**InjectBench** ([GitHub](https://github.com/chrispham-cyber/injectbench))

- Small benchmark that tests prompt injection attacks on 3 local LLMs through Ollama and checks if they leak a secret
- Also tests an LLM agent that can read notes, fetch a URL and "send" a report (sending is only logged)
- A stricter system prompt did not help in my tests. Blocking the send tool from sending the secret did.
- Python, FastAPI, Next.js, pytest, GitHub Actions

**Second Look (scam checker)** (personal project, October 2026)

- Web app that checks a text, screenshot, PDF or Word file and says if it looks like a scam, written in simple language for older people
- Uses an LLM, link checks (lookalike domains, domain age, phishing feeds) and a scikit-learn classifier I trained
- Uploaded files are scanned in a sandbox for macros and other malicious content before anything else reads them
- Python, FastAPI, Next.js, Claude API, Ollama, Docker

**Log Triage Tool** ([GitHub](https://github.com/chrispham-cyber/log-triage-tool))

- Python script that reads SSH auth logs and flags brute force attempts and logins that happen right after many failures
- Tested on the real auth.log from my SOC lab, with JSON output

**Phish Triage** ([GitHub](https://github.com/chrispham-cyber/phish-triage))

- Python script that checks a `.eml` file for SPF/DKIM/DMARC failures, spoofed headers, mismatched links and risky attachments, then gives a verdict

**This blog** ([chrispham-cyber.github.io](https://chrispham-cyber.github.io))

- Write-ups for Hack The Box, picoCTF and OverTheWire, plus beginner guides

---

## Certifications

- ISC2 Certified in Cybersecurity (CC), 2025, ID 2166799
- CompTIA Linux+, 2024, certificate 3K5P2KH1
- CodePath Intermediate Cybersecurity, 2024, credential 219886
- Google Cybersecurity Professional Certificate, 2023, credential VG2VAD3AJEEX

## Competitions and Teams

- Member of the CCDC and NCAE teams at UCF
- 1st place, FlagOps INIT @ FIU
- 2nd place, ShellHacks by Waymo (300+ teams)
- 3rd place, HackMiami XII, SFISSA CTF, and Lockdown UBNETDEF 2026
- Also competed in HPCC4, Lockdown V20 and WRCCDC Invitational (fall 2026)

## Labs and Practice

- 100+ CTF challenges on Hack The Box, TryHackMe and picoCTF
- Wrote up investigations for CyberDefenders labs, HTB Sherlocks and Blue Team Labs Online
- pwn.college System Security, 88 of 95 levels

---

## Skills

- **Languages:** Python, Bash, PowerShell, SQL, C, C++, Java
- **Blue team:** Wazuh, Splunk, Suricata, Sysmon, Wireshark, Volatility, Autopsy, MITRE ATT&CK
- **Other tools:** Nmap, Burp Suite, Metasploit, Hydra, John the Ripper, Ghidra, YARA
- **Platforms:** Kali Linux, Ubuntu, Windows Server, Docker, VMware, AWS

---

## Coursework

- UCF, fall 2026: Security in Computing, Computer Logic & Organization, Discrete Structures, Computer Science I
- MDC: Digital Forensics (Autopsy, John the Ripper), Cybersecurity Analysis (Wireshark, SIEM)
