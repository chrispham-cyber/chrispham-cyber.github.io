---
layout: post
title:  "Triple Knock"
date:   2025-07-04 17:10:00 -0400
categories: HTB-challenge easy
tags: HTB CTF writeup coding 
---

### DESCRIPTION
Following intel extracted from suspicious TOR traffic during Operation Blackout, you’ve uncovered a dump of leaked credentials linked to strategic user accounts.
Advanced Persistent Threat (APT) actors—believed to be working under Volnaya’s cyber division — are now actively attempting to use these credentials against high-value infrastructure.

As Nava “Sleuth” Patel, your task is to analyze shuffled login logs and identify user accounts being targeted.

The input begins with a single line containing two integers:

S — the number of log entries

N — the number of users

The next S lines each contain the following information, separated by spaces:

* A user ID (e.g., user_1)
* A timestamp in the format DD/MM HH:MM (The year is the same for all entries, and it is assumed that all months have 30 days)
* A login status in brackets: [success] or [failure]

The goal is to print a space-separated list of all user IDs that are flagged as targeted.
The list should be in increasing lexicographical order.

10 <= S <= 10^5

2 <= N <= 200
```
Example:

Input:

13 4

user_2 23/07 15:41 [success]
user_1 10/06 05:17 [failure]
user_3 20/04 13:53 [failure]
user_1 06/04 17:07 [success]
user_1 10/06 05:19 [failure]
user_3 18/11 10:32 [success]
user_1 12/08 11:52 [success]
user_1 10/06 05:25 [failure]
user_3 20/04 13:59 [failure]
user_3 24/02 22:44 [failure]
user_3 16/02 17:16 [success]
user_3 20/04 13:54 [failure]
user_3 21/11 11:44 [success]

Expected Output:

user_1 user_3

"user_1" and "user_3" each have made 3 failed login attempts within a 10 minute window.
```
### SOLUTION
```python
from collections import defaultdict

# Read the first line
input_line = input()
S, N = map(int, input_line.strip().split())

# Now read S lines of logs
logs = [input().strip() for _ in range(S)]

def parse_time_to_minutes(time_str):
    day, rest = time_str.split('/')
    month, hm = rest.split()
    hour, minute = map(int, hm.split(':'))
    total_minutes = (int(month) - 1) * 30 * 24 * 60 + (int(day) - 1) * 24 * 60 + hour * 60 + minute
    return total_minutes

def detect_targeted_accounts(S, N, logs):
    user_failures = defaultdict(list)
    
    # Step 1: Collect failure timestamps
    for log in logs:
        parts = log.strip().split()
        user = parts[0]
        timestamp = parse_time_to_minutes(f"{parts[1]} {parts[2]}")
        status = parts[3][1:-1]
        if status == 'failure':
            user_failures[user].append(timestamp)
    
    targeted_users = set()
    
    # Step 2: For each user, use sliding window to detect 3+ failures in 10 mins
    for user, times in user_failures.items():
        times.sort()
        left = 0
        for right in range(len(times)):
            # Move window's left edge
            while times[right] - times[left] > 10:
                left += 1
            if right - left + 1 >= 3:
                targeted_users.add(user)
                break

    return ' '.join(sorted(targeted_users))

print(detect_targeted_accounts(S, N, logs))
```
