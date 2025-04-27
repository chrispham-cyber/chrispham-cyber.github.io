---
layout: post
title:  "Event-Viewing"
date:   2025-04-25 19:25:00 -0400
categories: PICO-challenge forensics medium
tags: pico CTF writeup evtx log 
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/Event-Viewing/1.png)

### SOLUTION
First, we need to convert `evtx` to `xml` to analyze
```bash
pip install python-evtx
source myenv/bin/activate
python3 evtx_dump.py some.evtx > some.xml
```

We read the hint and do research about `EventID`
![](assets/img/pico/Event-Viewing/2.png)

Now we know some ID number of events, so filter it with `grep`. `A25` flag can list 25 lines after each match.
```bash
cat some.xml | grep -A25 "1033</EventID>"
```
![](assets/img/pico/Event-Viewing/3.png)

We get the first part of the flag, and the malicious software's name.
```bash
cat some.xml | grep -A25 "Totally_Legit_Software"

```
![](assets/img/pico/Event-Viewing/5.png)

We got the second part of the flag, now filter the shut down eventid.
```bash
cat some.xml | grep -A25 "1074</EventID>"

```
![](assets/img/pico/Event-Viewing/4.png)
