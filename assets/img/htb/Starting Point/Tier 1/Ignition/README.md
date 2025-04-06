# Task 1: Which service version is found to be running on port 80?
nginx 1.14.2

# Task 2: What is the 3-digit HTTP status code returned when you visit http://{machine IP}/?
`curl -v {ip}` => 302

# Task 3: What is the virtual host name the webpage expects to be accessed by?
ignition.htb

# Task 4: What is the full path to the file on a Linux computer that holds a local list of domain name to IP address pairs?
/etc/hosts

# Task 5: Use a tool to brute force directories on the webserver. What is the full URL to the Magento login page?
http://ignition.htb/admin

# Task 6: Look up the password requirements for Magento and also try searching for the most common passwords of 2023. Which password provides access to the admin account?
Google search `common password in 2023` and we will get `qwerty123` for admin's account

# Flag:
After login, we will get the flag.
