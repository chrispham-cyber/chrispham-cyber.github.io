---
# the default layout is 'page'
icon: fas fa-file-alt
order: 4
---

# Resume

## Education

**University of Central Florida** — *Orlando, FL*

Bachelor of Science, Computer Science — *Expected May 2029*

---

## Certifications & Achievements

- **ISC2 Certified in Cybersecurity (CC)** — ID: 2166799 — entry-level security certification (2025)
- **CompTIA Linux+** — Certificate: 3K5P2KH1 — system administration and security concepts (2024)
- **Google Cybersecurity Professional Certificate** — 8-course specialization (2023)
- **CodePath Intermediate Cybersecurity** (2024)
- Member — **Collegiate Cyber Defense Competition (CCDC)**, UCF
- Member — **National Center of Academic Excellence (NCAE)**

**Competitions**

- 1st place — FlagOps INIT @ FIU CTF
- 2nd place — ShellHacks by Waymo (300+ teams)
- 3rd place — HackMiami XII · SFISSA CTF · Lockdown UBNETDEF 2026
- 100+ CTF challenges completed — HackTheBox, TryHackMe, picoCTF

---

## Technical Skills

- **Languages:** Python, Bash, PowerShell, SQL, C++, Java
- **Security Tools:** Wireshark, Nmap, Hydra, Burp Suite, Metasploit, Sysmon, Autopsy, John the Ripper, YARA
- **SIEM & Monitoring:** Wazuh, Splunk, syslog; MITRE ATT&CK
- **Platforms:** Kali Linux, Linux, Windows, Docker, VMware, AWS
- **Web:** HTML, CSS, JavaScript, Bootstrap, Jekyll, Git, MySQL

---

## Projects

**Home SOC Lab** — [github.com/chrispham-cyber/home-soc-lab](https://github.com/chrispham-cyber/home-soc-lab)

- Deployed a Wazuh SIEM and monitored a Windows endpoint with Sysmon across isolated VMs
- Simulated attacks from Kali and mapped detections to MITRE ATT&CK (T1110, T1059, T1105, T1087, T1033)
- Wrote and tested a custom Wazuh detection rule for an uncovered technique, and documented a host-based SIEM blind spot with a remediation plan

**Log Triage Tool** — [github.com/chrispham-cyber/log-triage-tool](https://github.com/chrispham-cyber/log-triage-tool)

- Built a Python CLI that parses SSH auth logs to detect brute-force attacks (sliding-window threshold) and post-compromise logins, mapped to MITRE ATT&CK (T1110)
- Validated against real logs from my SOC lab; emits JSON and non-zero exit codes for SIEM/CI pipelines

**Phishing Email Analyzer** — [github.com/chrispham-cyber/phish-triage](https://github.com/chrispham-cyber/phish-triage)

- Built a Python tool that triages `.eml` files for phishing: SPF/DKIM/DMARC checks, spoofed headers, lookalike links, and risky attachments
- Scores each message and returns a verdict; catches sender spoofing and mismatched-link tricks

**Cybersecurity Blog** — [chrispham-cyber.github.io](https://chrispham-cyber.github.io)

- Author technical write-ups on Linux, CTF challenges, and defensive security

---

## Relevant Coursework

- **Digital Forensics** — forensic lifecycle using Autopsy and John the Ripper to identify digital evidence
- **Cybersecurity Analysis** — Wireshark packet analysis and SIEM methodologies
- **Security in Computing** · **Computer Logic & Organization** · **Computer Science I**

---

# Experience

**WordPress Developer** — *2021 – 2022*

- Built and maintained WordPress websites using page-builder templates
- Configured themes and plugins; handled routine site updates and maintenance
