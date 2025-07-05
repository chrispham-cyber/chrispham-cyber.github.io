---
layout: post
title:  "Threat Index"
date:   2025-07-04 09:10:00 -0400
categories: HTB-challenge very-easy
tags: HTB CTF writeup coding 
---

### DESCRIPTION
You are monitoring data streams exiting suspicious TOR nodes, believed to be part of the Empire of Volnaya’s covert APT infrastructure.

As Talion “Little Byte” Reyes you’ve been assigned to identify and evaluate indicators of compromise embedded in the exfiltrated traffic.

Your job is to scan each stream for high-risk keywords associated with known attack patterns linked to Operation Blackout.

Each keyword has a weight representing its severity, based on intelligence recovered from earlier breaches.

The more often a keyword appears — and the higher its weight - the greater the threat posed by that stream.

The data stream contains only lowercase letters and digits.

You must calculate the threat score of each stream using the formula:

threat score = Σ (occurrences of keyword × keyword weight)

Here is the list of all the keywords and their associated weight:

KEYWORD      -> WEIGHT

"scan"       -> 1

"response"   -> 2

"control"    -> 3

"callback"   -> 4

"implant"    -> 5

"zombie"     -> 6

"trigger"    -> 7

"infected"   -> 8

"compromise" -> 9

"inject"     -> 10

"execute"    -> 11

"deploy"     -> 12

"malware"    -> 13

"exploit"    -> 14

"payload"    -> 15

"backdoor"   -> 16

"zeroday"    -> 17

"botnet"     -> 18

30 <= data stream length <= 10^6
```
Example:

Input:
payloadrandompayloadhtbzerodayrandombytesmalware

Expected output:
60

Analyzing the data stream:
payloadrandompayloadhtbzerodayrandombytesmalware
^^^^^^^      ^^^^^^^   ^^^^^^^           ^^^^^^^
  15           15        17                13

Calculating the threat score:

threat score = 2 * 15 + 17 + 13 = 60
```

### SOLUTION
```python
n = input()

# calculate answer
def calculate_threat_score(data_stream):
    keywords = {
        "scan": 1,
        "response": 2,
        "control": 3,
        "callback": 4,
        "implant": 5,
        "zombie": 6,
        "trigger": 7,
        "infected": 8,
        "compromise": 9,
        "inject": 10,
        "execute": 11,
        "deploy": 12,
        "malware": 13,
        "exploit": 14,
        "payload": 15,
        "backdoor": 16,
        "zeroday": 17,
        "botnet": 18
    }

    # count non-overlapping occurrences of keyword `sub` in string `s`
    def count_occurrences(s, sub):
        count = 0
        i = 0
        while True:
            i = s.find(sub, i)
            if i == -1:
                break
            count += 1
            # Move past the found keyword to avoid overlap
            i += len(sub)
        return count

    # Main threat score accumulator
    score = 0
    for kw, weight in keywords.items():
        occurrences = count_occurrences(data_stream, kw)
        score += occurrences * weight

    return score

print(calculate_threat_score(n))
```
