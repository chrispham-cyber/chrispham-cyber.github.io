# Task 1: Which Nmap switch can we use to enumerate machines when our ping ICMP packets are blocked by the Windows firewall?
-Pn

# Task 2: What does the 3-letter acronym SMB stand for?
Server Message Block

# Task 3: What port does SMB use to operate at?
445

# Task 4: What command line argument do you give to `smbclient` to list available shares?
-L

# Task 5: What character at the end of a share name indicates it's an administrative share?
$

# Task 6: Which Administrative share is accessible on the box that allows users to view the whole file system?
C$

# Task 7: What command can we use to download the files we find on the SMB Share?
get

# Task 8: Which tool that is part of the Impacket collection can be used to get an interactive shell on the system?
psexec.py

# Flag:
There are 2 ways to get this flag:
- Using `smbclient`: access to `C$` share with user `Administrator`, flag file in `Desktop`
- Using `psexec.py`: After installing `psexec.py`, run it `psexec.py administrator@{ip}`, then we will have remote access to the target's machine.
