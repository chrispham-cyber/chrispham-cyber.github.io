---
layout: post
title:  "Cred Hunter"
date:   2025-07-04 10:10:00 -0400
categories: HTB-challenge coding easy
tags: HTB CTF writeup 
---

### DESCRIPTION
During a red team engagement against CygnusCorp, your team gained access to a third-party analytics platform that had been improperly secured.
This system — used for employee behavior profiling — contained a massive, unsanitized credential dump, blending email addresses and plaintext passwords collected through multiple internal tools, test systems, and staging environments.

Fortunately, CygnusCorp enforces a strict email naming policy internally:
All employees use firstname + first letter of their last name as their username (lowercase), followed by an official company domain.

Examples:

* alicej@cygnus.com
* joshr@cygnuscorp.eu

Many users embed their first names into their passwords — a predictable pattern you can exploit to associate emails with passwords and identify potential valid logins.
Based on this pattern, your task is to extract all possible (email, password) pairs from this messy dump.

Examples of possible pairs:

Email: joshb@cygnuscorp.com

Password: joshRocks!@

Valid pair

However:

Email: alicew@cygnus.eu

Password: SuperSecurePassword

No match (does not contain "alice", and thus cannot be paired with the email)

Input format:

The first line contains an integer N — the number of strings in the dump.

The next N lines each contain a single string (one per line). This can be an email or a password.

Output format:

For each valid (email, password) pair, output a line in the format:

email password

The output pairs must be sorted lexicographically by email.

If one email has multiple valid passwords, sort those lexicographically by their passwords and output each pair on a new line.

Notes:
* An (email, password) pair is valid if the users first name (extracted from the email address) appears as a substring in the password.
* Not all valid email addresses will have a corresponding password pair, and vice versa.
* Anything that does not follow the email format can be considered a password.
* A password can contain lowercase letters, uppercase letters, digits, and special characters.
* Uppercase to lowercase conversion is not required.
* If no valid pairs exist, the output should be empty.

10 <= N <= 10^4

8 <= Characters in each string <= 50
```
Example:
Input:
17
lisabethf@cygnuscloud.com
nevin2024!@
nevinn@cygnus.com
sTaaTo17oqJ9Tq&0KdLRT3jzyiNmoQU
lisabeth2024
1I&AmGfRLrB&!6fU
wylo789
tevin2025!
llmc$v#Z8q
anh!9wou@gd2GVS!
8i0g52KB&aRpfs$WtCrzzpG@Lm8
joiceqwerty2025
crNoZ80Q
Sn&BYwA1F43ItYg2U
LVkGDbM$B!Gqe3v
joicep@cygnusdevs.eu
2025joiceTheDev!@

Expected output:
joicep@cygnusdevs.eu 2025joiceTheDev!@
joicep@cygnusdevs.eu joiceqwerty2025
lisabethf@cygnuscloud.com lisabeth2024
nevinn@cygnus.com nevin2024!@
```


### SOLUTION
```python
import re

N = int(input())
data = [input().strip() for _ in range(N)]

emails = []
passwords = []

# Accept emails from any cygnus*.com or cygnus*.eu subdomain
email_pattern = re.compile(r'^[a-z]+[a-z]@cygnus[a-z]*\.(com|eu)$')

for item in data:
    if email_pattern.match(item):
        emails.append(item)
    else:
        passwords.append(item)

# Extract firstname from email (everything before the last char of the username)
email_firstname_map = {}
for email in emails:
    username = email.split('@')[0]
    firstname = username[:-1]
    email_firstname_map[email] = firstname

# Find matching passwords
results = []
for email, firstname in email_firstname_map.items():
    for pw in passwords:
        if firstname in pw:
            results.append((email, pw))

# Sort results by email, then password
results.sort()

for email, pw in results:
    print(f"{email} {pw}")
```
