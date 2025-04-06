# Task 1: How many TCP ports are open?
2

# Task 2: What is the name of the directory that is available on the FTP server?
mail_backup

# Task 3: What is the default account password that every new member on the "Funnel" team should change as soon as possible?
Connect to `FTP` and download password PDF file, and we will get the password.

# Task 4: Which user has not changed their default password yet?
Read `Welcome` file and use tool like `crackmapexec` or `hydra` to bruce force.

# Task 5: Which service is running on TCP port 5432 and listens only on localhost?
postgresql

# Task 6: Since you can't access the previously mentioned service from the local machine, you will have to create a tunnel and connect to it from your machine. What is the correct type of tunneling to use? remote port forwarding or local port forwarding?
local port forwarding

# Task 7: What is the name of the database that holds the flag?
secrets

# Task 8: Could you use a dynamic tunnel instead of local port forwarding? Yes or No.
Yes

# Flag:
After connecting to `Postgresql`, use `\l` to show databases, `\c` to connect to database, `\dt` to list table.
