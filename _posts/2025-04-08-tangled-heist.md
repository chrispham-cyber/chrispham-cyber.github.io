---
layout: post
title:  "Tangled Heist"
date:   2025-04-08 14:00:00 -0400
categories: HTB-challenge forensics easy
tags: HTB CTF writeup wireshark log 
---

### SOLUTION
**Q1: Which is the username of the compromised user used to conduct the attack? (for example: username)**

We search for `LDAP` protocol and get the answer.
![](assets/img/htb/tangled-heist/1.png)

**Q2: What is the Distinguished Name (DN) of the Domain Controller? Don't put spaces between commas. (for example: CN=...,CN=...,DC=...,DC=...)

Search `ldap contains "OU=Domain Controller"`
![](assets/img/htb/tangled-heist/2.png)

**Q3: Which is the Domain managed by the Domain Controller? (for example: corp.domain) **

We can get this from Ques1.

**Q4: How many failed login attempts are recorded on the user account named 'Ranger'? (for example: 6)**

After doing some researchs, we know that `badPwdCount` used for number of times the user tried to log on to the account using an incorrect password.

Search `ldap contains "badPwdCount" and ldap contains "Ranger"` **case sensitive**
![](assets/img/htb/tangled-heist/3.png)

**Q5: Which LDAP query was executed to find all groups? (for example: (object=value))**

As we know the IP address of the attacker, so search `ip.src == IP and ldap contains "group"`
![](assets/img/htb/tangled-heist/4.png)

**Q6: How many non-standard groups exist? (for example: 1)**

Search `ldap contains "group"` and we see 2 `searchResEntry` numbers, so try it all.
![](assets/img/htb/tangled-heist/5.png)

**Q7: One of the non-standard users is flagged as 'disabled', which is it? (for example: username)**

To find this information we need to inspect the `userAccountControl` attribute. And [UAC](https://www.techjutsu.com/uac-decoder)

Search `ldap.type == "userAccountControl" and ldap.AttributeValue == "514"`. We see 3 usernames, try it all.
![](assets/img/htb/tangled-heist/6.png)

**Q8: The attacker targeted one user writing some data inside a specific field. Which is the field name? (for example: field_name)**

We can notice that there are some `modifyRequest` packets, let analyze them.
![](assets/img/htb/tangled-heist/7.png)

**Q9: Which is the new value written in it? (for example: value123)**

We can get the answer from Q8

**Q10: The attacker created a new user for persistence. Which is the username and the assigned group? Don't put spaces in the answer (for example: username,group)**

We can see `addRequest` and `modifyRequest`, analyze it.
![](assets/img/htb/tangled-heist/8.png)

**Q11: The attacker obtained an hash for the user 'Hurricane' that has the UF_DONT_REQUIRE_PREAUTH flag set. Which is the correspondent plaintext for that hash?  (for example: plaintext_password)**

Look up for `Hurricane` username and we see `KRB5` protocol.
![](assets/img/htb/tangled-heist/9.png)

Export packet to `PDML` file. PDML files are a powerful way to export and analyze packet capture data from Wireshark. They provide a structured format that can be easily processed and integrated with other tools, making them valuable for network analysis and reporting.
![](assets/img/htb/tangled-heist/10.png)

Convert it to `krb` hash by `krb2john` and crack it with `john`
![](assets/img/htb/tangled-heist/11.png)

