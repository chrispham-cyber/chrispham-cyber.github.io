---
layout: post
title:  "Setup Splunk on Kali"
date:   2025-12-18 01:20:00 -0400
categories: Blog Beginner
tags: blog setup kali-linux splunk SIEM lab
pin: true
image:
    path: assets/img/blog/SetupSplunk/banner.jpg
---

This blog is for anyone who loves hacking and doesn't know how to set up a SIEM homelab (Splunk).

## Download Splunk 

```bash
wget -O splunk_soar-unpriv-6.2.1.305-7c40b403-el7-x86_64.tgz "https://download.splunk.com/products/splunk_soar-unpriv/releases/6.2.1/linux/splunk_soar-unpriv-6.2.1.305-7c40b403-el7-x86_64.tgz"
```

## Setup Environment

After downloading, we need to extract it. Change to `root` mode to run Splunk.

```bash
sudo tar -xzvf ./splunk_soar-unpriv-6.2.1.305-7c40b403-el7-x86_64.tgz -C /opt

sudo -i

cd /opt/splunk/bin

./splunk start
```

press `Space` to read all license and type `y` to continue.

set username and password (at least 8 characters)

wait a few minutes, it will give you a link, open it.

![](assets/img/blog/SetupSplunk/1.png)

Source: [How to setup Splunk](https://www.youtube.com/watch?v=Tox5L_QCiKw)
