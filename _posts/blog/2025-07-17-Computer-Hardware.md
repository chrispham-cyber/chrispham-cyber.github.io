---
layout: post
title:  "Get To Know Your Computer"
date:   2025-07-17 23:20:00 -0400
categories: Blog Beginner
tags: blog ssd hdd cpu gpu ram psu motherboard 
pin: true
image:
    path: assets/img/blog/Computer-Hardware/banner.png
---

If you’re diving into cybersecurity, whether you dream of becoming a hacker, defender, or forensics wizard you need to understand the machine you’re working with.

Before you start popping shells or analyzing malware, take a moment to understand **how a computer actually works under the hood**. Think of it like learning how a car engine runs before you become a mechanic or racer.

Let’s break down the key hardware components in a beginner friendly way.

Table of contents:
* [CPU](#central-processing-unit-cpu)
* [Motherboard](#motherboard)
* [RAM](#ram-random-access-memory)
* [HDD](#hdd-hard-disk-drive)
* [SSD](#ssd-solid-state-drive)
* [PSU](#power-supply-unit-psu)
* [GPU](#gpu-graphics-processing-unit)
* [Input and Output](#input-and-output-devices)
* [Why Matter](#why-this-matters-for-cybersecurity)
* [Final Thoughts](#final-thoughts)

## Central Processing Unit (CPU) 
![](assets/img/blog/Computer-Hardware/1.jpg)

The **CPU** is the “brain” of your computer. It carries out instructions from software and controls most of what your system does.

* It processes everything from opening a file to running malware detection tools.
* The speed and power of your CPU affects how fast your computer responds.
* If your computer was a human, the CPU would be its thinking brain.

Understanding CPU usage can help you detect things like **cryptojacking** or **malware** that hogs system resources.

## Motherboard 
![](assets/img/blog/Computer-Hardware/2.jpg)

The **motherboard** connects all parts of the computer together: CPU, RAM, storage, GPU, and more. It’s basically the “circuit board highway” for your computer.

* Every component plugs into it.
* It handles communication between hardware parts.
* Without it, your computer is just a bunch of disconnected parts.

You’ll often deal with **BIOS/UEFI** (firmware on the motherboard), which can be a target for **low level attacks like rootkits**.

## RAM (Random Access Memory) 
![](assets/img/blog/Computer-Hardware/3.jpg)

**RAM** is like your computer’s short term memory. It temporarily stores the data your computer needs right now.

* Faster than your hard drive but not permanent.
* More RAM, better multitasking and faster performance.
* When your system shuts down, RAM is wiped.

RAM can store **sensitive info**, like passwords or encryption keys, temporarily making it a target during **live forensics** or **memory dumps**.

## HDD (Hard Disk Drive) 
![](assets/img/blog/Computer-Hardware/4.jpg)

**HDDs** are your computer’s traditional long term storage.

* Uses spinning magnetic disks to store data.
* Cheaper and larger in size (in GB or TB).
* Slower than newer storage types.

HDDs store everything from **log files** to **malware**. Tools like FTK or Autopsy help investigate HDDs during digital forensics.

## SSD (Solid-State Drive) 
![](assets/img/blog/Computer-Hardware/5.jpg)

**SSDs** are like upgraded HDDs. They store data with flash memory (no moving parts), making them:

* Much faster than HDDs
* More durable (especially for laptops)
* Usually smaller in size (but that’s changing)

SSDs can make data wiping harder to fully analyze, which matters in forensics and incident response.

## Power Supply Unit (PSU) 
![](assets/img/blog/Computer-Hardware/6.jpg)

The **PSU** converts electricity from the wall into usable power for the computer.

* Provides power to every component
* Bad PSU = system crashes, restarts, or even permanent damage
* Measured in watts (W)

While often overlooked, hardware level attacks or tampering with power sources can be part of physical attacks or DOS in critical infrastructure.

## GPU (Graphics Processing Unit) 
![](assets/img/blog/Computer-Hardware/7.jpg)

The **GPU** handles rendering images, videos, and 3D graphics. Originally built for gaming, now they’re used for:

* **Machine learning**
* **Password cracking**
* **Crypto mining**

GPUs are used in brute-force attacks and hash cracking. Knowing GPU limits helps defend against resource exploitation.

## Input and Output Devices 
![](assets/img/blog/Computer-Hardware/8.png)

**Input devices** are how you tell the computer what to do:

* Keyboard, mouse, microphone, webcam, etc.

**Output devices** are how the computer shows you results:

* Monitors, printers, speakers, etc.

**In Cybersecurity:**

* Input devices can be exploited (e.g., **keyloggers**, **webcam hijacking**).
* Output devices can leak data (e.g., via **screen captures**, **printer misuse**, or **visual hacking**).

## Why This Matters for Cybersecurity

Understanding hardware isn’t just for PC builders, it’s essential for cybersecurity:

* Knowing where data is stored = better forensic investigations.
* Knowing what can be attacked = stronger defenses.
* Understanding how hardware interacts = smarter hacking.

Think of it this way:

> **Before you can hack the system, you gotta understand the system.**

## Final Thoughts

You don’t need to memorize every wire and chip. But knowing what each piece does helps you become a better analyst, pentester, or engineer.

If you’re just getting started:

* Open up an old PC or laptop.
* Identify each part based on this guide.
* Try tools like **Speccy**, **CPU-Z**, or even Linux commands (`lshw`, `lsblk`, etc.) to inspect your system.

Stay curious, stay safe and remember: **every hacker was a beginner once.**

Happy Hacking!!!
