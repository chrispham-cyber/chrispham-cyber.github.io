---
layout: post
title:  "Basics of Computer Networking"
date:   2025-07-24 01:20:00 -0400
categories: Blog Beginner
tags: blog tcp ip ipv4 ipv6 topologies network subnet dns
pin: true
image:
    path: assets/img/blog/Computer-Network/banner.jpg
---

Let’s face it, if you’re diving into cybersecurity without understanding how devices actually talk to each other, you’re flying blind. Networks are the battlefield of modern cyber warfare, and if you want to defend systems, you need to know what’s under the hood.

So, let’s break down the basics of computer networking, no boring textbook talk, just real-world knowledge you actually need.

Table of Contents:
* [What Is Computer Networking](#what-is-computer-networking)
* [TCP/IP](#tcpip)
* [Routers and Switches](#routers-and-switches)
* [Network Topologies](#network-topologies)
* [IP Addressing & Subnetting](#ip-addressing--subnetting)
* [DNS](#dns-domain-name-system)
* [Network Security Measures](#network-security-measures)
* [Practices](#practices)
* [Final Thoughts](#final-thoughts)

## What Is Computer Networking?
Computer networking is simply connecting computers and devices so they can share information. Think file sharing, streaming Netflix, sending emails, or launching a DDoS attack.
Because almost every cyber attack, malware, phishing, ransomware, MITM, sniffing, rides on a network. Knowing how data flows helps you intercept, analyze, and protect it.

## TCP/IP 

![](assets/img/blog/Computer-Network/1.jpg)

When two devices talk online, they use protocols. The most important one? TCP/IP.

### TCP (Transmission Control Protocol)
* Breaks data into packets
* Ensures packets arrive in the right order
* Retransmits missing pieces
* Think: Netflix buffering so your show doesn’t glitch

### IP (Internet Protocol)
* Assigns every device a unique address 
* Directs traffic to the right destination
* Think: The GPS of the internet

Together, TCP/IP is the foundation of digital communication. Understanding it helps you analyze network traffic, debug issues, and catch attacks in action.

## Routers and Switches

![](assets/img/blog/Computer-Network/2.jpg)

Both devices help move data across networks, but they play very different roles.

### Switch:
* Operates in LANs
* Connects multiple devices in the same network
* Forwards data based on MAC addresses
* Think of it as your office’s internal delivery system

### Router:
* Connects different networks together 
* Forwards data based on IP addresses
* Acts as the border guard between your LAN and the big, bad web

Note:
A compromised switch? Internal chaos.  A compromised router? External access, your whole network could be exposed.

## Network Topologies

![](assets/img/blog/Computer-Network/3.png)

A network topology is basically a map of how devices are arranged and connected.

The Common Types:
* Star: Devices connect to a central hub 
* Bus: One long cable connects all devices
* Mesh: Devices connect to each other directly 
* Ring: Devices form a circle, each device passes data to the next

Knowing your topology helps you:
* Plan secure networks
* Identify single points of failure
* Troubleshoot faster

## IP Addressing & Subnetting 
Every device on a network has an IP address, like a phone number for your device.

### IPv4:
* Example: 192.168.1.1
* Limited addresses

### IPv6:
* Example: 2001:0db8:85a3:0000:0000:8a2e:0370:7334
* Designed to support the exploding number of connected devices

Subnetting:
* Divides a big network into smaller parts
* Helps organize, secure, and control traffic

Subnetting helps contain breaches and limit access.

## DNS (Domain Name System)
It turns human friendly names like google.com into IP addresses like 8.8.8.8.

Without DNS, you'd need to memorize IPs for every website. 

Why it matters in cybersecurity:
* DNS spoofing (cache poisoning) can redirect users to malicious websites
* DNS logging helps track unusual domain lookups during an attack

Use DNS filtering and secure DNS protocols to add protection.

## Network Security Measures

![](assets/img/blog/Computer-Network/4.png)

If you build a network and don’t secure it, attackers will treat it like an open buffet.

| Security Measure                | What It Does                               |
| ------------------------------- | ------------------------------------------ |
| **Firewall**                    | Blocks/filters incoming & outgoing traffic |
| **VLANs/Subnets**                       | Segments network to isolate traffic        |
| **Access Control Lists (ACLs)** | Defines who can access what                |
| **Encryption**                  | Protects data in transit                   |
| **IDS/IPS**                     | Detects and blocks threats in real time    |

Security should be built into the network, not added as an afterthought.

## Why Networking Knowledge Makes You Dangerous
Whether you want to become a pen tester, SOC analyst, blue teamer, or red teamer, you’ll constantly interact with networks.

Here’s why understanding networking is:
* You can trace threats across connections
* You can analyze packet data with tools like Wireshark
* You can identify misconfigs that open doors to attackers
* You can simulate attacks in labs like TryHackMe or HackTheBox

## Practices
Try these beginner friendly labs and exercises:
* Use ping, ipconfig, tracert to explore your own network
* Capture traffic in Wireshark and watch TCP handshakes
* Explore subnet calculators to break down IP ranges
* Set up a virtual firewall and block/allow specific ports

## Final Thoughts
Networking isn’t just wires and blinking lights, it’s the circulatory system of cybersecurity. Master it, and you’ll understand how attackers move, how defenders stop them, and how the entire internet operates.

So don’t skip the fundamentals, this is your tactical edge.

Happy Hacking!
