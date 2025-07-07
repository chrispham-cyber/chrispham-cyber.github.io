---
layout: post
title:  "ElectricBreeze-2"
date:   2025-07-06 22:07:00 -0400
categories: HTB-sherlock Malware-Analysis easy
tags: HTB CTF writeup 
image:
    path: assets/img/htb/ElectricBreeze/banner.png
---

### CHALLENGE DESCRIPTION
Your boss is concerned about Volt Typhoon and some of their malware developments. He has requested that you obtain a copy of the associated malware and conduct a static analysis to identify any useful information. Please report back with your findings.

### SOLUTION 

**Use MalwareBazaar to download a copy of the file with the hash '4bcedac20a75e8f8833f4725adfc87577c32990c3783bf6c743f14599a176c37'. What is the URL to do this?**

Go to [MalwareBazaar](https://bazaar.abuse.ch/browse/), search `sha256:4bcedac20a75e8f8833f4725adfc87577c32990c3783bf6c743f14599a176c37`, right click on the download link and copy it.

<details>
<summary><b>Answer</b></summary>
https://bazaar.abuse.ch/download/4bcedac20a75e8f8833f4725adfc87577c32990c3783bf6c743f14599a176c37/
</details>

**What is the password to unlock the zip?**

> zip2john turns a password-protected ZIP file into a hash format that John the Ripper can crack.

```bash
zip2john 4bcedac20a75e8f8833f4725adfc87577c32990c3783bf6c743f14599a176c37.zip > hash
```

Now crack it with `rockyou` wordlist.

```bash
john hash --wordlist=$ROCKU
```

<details>
<summary><b>Answer</b></summary>
infected
</details>

**What is the extension of the file once unzipping?**

We will get the answer when unzip the file.

<details>
<summary><b>Answer</b></summary>
.jar
</details>

**What is a suspicious directory in META-INF?**

Go to `Meta` directory and list everything inside it

```bash
ls */*/*
```

<details>
<summary><b>Answer</b></summary>
Director_tomcat_memShell
</details>

**One of the files in this directory may give some insight into the threat actor's origin. What is the file?**

We will see 2 `pom` files.

<details>
<summary><b>Answer</b></summary>
pom.xml
</details>

**According to Google Translate, what language is the suspicious text?**
<details>
<summary><b>Answer</b></summary>
Chinese
</details>

**What is the translation in English?**
<details>
<summary><b>Answer</b></summary>
Check for the latest version
</details>

**According to this file, what is the application's name?**

We can see the tag `filename` in the file.

<details>
<summary><b>Answer</b></summary>
VersaTest
</details>

**The VersaMem web shell works by hooking Tomcat. Which file holds the functionality to accomplish this?**

We see `web shell`, go back and we will see `com` directory.

<details>
<summary><b>Answer</b></summary>
com/versa/vnms/ui/TestMain.class
</details>

**There is a command that determines the PID for the hook. What is the program used in this line of code?**

`/usr/bin/` It’s a directory on Unix-like systems, search for `/usr/bin`

<details>
<summary><b>Answer</b></summary>
pgrep
</details>

**The functionality for the webshell is in a different file. What is its name?**
<details>
<summary><b>Answer</b></summary>
com/versa/vnms/ui/init/WriteTestTransformer.class
</details>

**What is the name of the function that deals with authentication into the webshell?**

Look at `ClassLoader`

<details>
<summary><b>Answer</b></summary>
getInsertCode
</details>

**What request parameter must be present to activate the webshell logic?**

By analyzing the file, we will see `getParameter`

<details>
<summary><b>Answer</b></summary>
p
</details>

**What is the hardcoded access password used to validate incoming webshell requests?**

By analyzing the file, we will see the `access password` in short.

<details>
<summary><b>Answer</b></summary>
5ea23db511e1ac4a806e002def3b74a1
</details>

**What type of encryption is used?**

`SecretKeySpec`

<details>
<summary><b>Answer</b></summary>
AES
</details>

**What cipher mode is used to encrypt the credentials?**
<details>
<summary><b>Answer</b></summary>
ECB
</details>

**What is the key?**
<details>
<summary><b>Answer</b></summary>
56, 50, 97, 100, 52, 50, 99, 50, 102, 100, 101, 56, 55, 52, 99, 53, 54, 101, 101, 50, 49, 52, 48, 55, 101, 57, 48, 57, 48, 52, 97, 97
</details>

**What is the value of the key after decoding?**

Look at this part
```
SecretKeySpec secretKey = new SecretKeySpec(new byte[]{
    56, 50, 97, 100, 52, 50, 99, 50,
    102, 100, 101, 56, 55, 52, 99, 53,
    54, 101, 101, 50, 49, 52, 48, 55,
    101, 57, 48, 57, 48, 52, 97, 97
}, "AES");
```
These are ASCII byte values. Convert each to a character.

<details>
<summary><b>Answer</b></summary>
82ad42c2fde874c56ee21407e90904aa
</details>

**To avoid static detection, the method name is constructed at runtime and passed to java.lang.reflect.Method, what is the decimal byte array used to construct the string name?**
<details>
<summary><b>Answer</b></summary>
100, 101, 102, 105, 110, 101, 67, 108, 97, 115, 115
</details>

**What is the Base64-encoded string that is returned to the client if the class is successfully defined?**
<details>
<summary><b>Answer</b></summary>
R2qBFRx0KAZceVi+MWP6FGGs8MMoJRV5M3KY/GBiOn8=
</details>

**What is the decrypted string?**

```bash
python3 -m venv myenv
source myenv/bin/activate

pip install pycryptodome
```

```python
from Crypto.Cipher import AES
import base64

key = b'82ad42c2fde874c56ee21407e90904aa'  # 32 bytes key
cipher = AES.new(key, AES.MODE_ECB)

def decrypt(ciphertext_b64):
    ciphertext = base64.b64decode(ciphertext_b64)
    decrypted = cipher.decrypt(ciphertext)
    pad_len = decrypted[-1]
    return decrypted[:-pad_len].decode(errors='replace')

print(decrypt("R2qBFRx0KAZceVi+MWP6FGGs8MMoJRV5M3KY/GBiOn8="))
print(decrypt("Q6ajR83GUmjv9aiPylz2pg=="))
```

<details>
<summary><b>Answer</b></summary>
lassDefine by clzd
</details>

**There is another class to log passwords for exfiltration. What is this file?**
<details>
<summary><b>Answer</b></summary>
com/versa/vnms/ui/init/CapturePassTransformer.class
</details>

**What is the main malicious function in this class?**

Look at `ClassLoader`

<details>
<summary><b>Answer</b></summary>
captureLoginPasswordCode
</details>

**The same AES key from the previous method is being used. What is the variable name it is being saved as in this function?**
<details>
<summary><b>Answer</b></summary>
secretKey
</details>

**What file is used to hold credentials before exfiltration?**

```
    String logData = Base64.getEncoder().encodeToString(encryptData);
    String logFile = "/tmp/.temp.data";
    String cmd = "grep -q " + logData + " " + logFile + " || echo " + logData + " >> " + logFile;
    String[] command = {
        "/bin/bash", "-c", cmd
    };
```
<details>
<summary><b>Answer</b></summary>
/tmp/.temp.data
</details>

