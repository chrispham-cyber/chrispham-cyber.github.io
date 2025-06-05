---
layout: post
title:  "TrainingDay"
date:   2025-06-04 23:07:00 -0400
categories: HTB-sherlock Malware-Analysis easy
tags: CTF writeup malware
image:
    path: assets/img/htb/TrainingDay/banner.png
---

### CHALLENGE DESCRIPTION
A fresh new day, a well-rested cybersecurity professional—ready to learn something new after a chaotic week. Scrolling through challenges, they stumble upon TrainingDay, download the artifacts, and boom—three different binaries, each doing its own thing. Do they panic? Nope. This is exactly what they signed up for—some good old-fashioned reversing fun. If this sounds like you, what are you waiting for? Grab your debugger and dive in!

### SOLUTION 

We will use VirusTotal to analyze these malwares.

**What is sha256sum hash of argument_baby_1.exe ?**
<details>
<summary><b>Answer</b></summary>
dc6267608ddfcc5c80571ccd46475a03fb667baf8620d0e91c93ccacacf97ef6
</details>

**Can you find development enviroment of malware author (e.g:ide) ?**
Click on `Details` tab, scroll down and we will see VS2022, which means ...
<details>
<summary><b>Answer</b></summary>
Visual Studio
</details>

**What CPU architecture was argument_baby_1.exe compiled for ?**

Search `CPU [filename]` and click on first link, scroll down and we can notice something. [Hybrid-analysis](https://hybrid-analysis.com/sample/dc6267608ddfcc5c80571ccd46475a03fb667baf8620d0e91c93ccacacf97ef6/67ef30fdee7849ab710a663c).

<details>
<summary><b>Answer</b></summary>
32 bit
</details>

**Is argument_baby_1.exe a symbol-stripped binary?**
```bash
file [filename]
```

If it shows stripped, it's true.

<details>
<summary><b>Answer</b></summary>
false
</details>

**Retrieve the full PDB file path from the debug information of argument_baby_1.exe**
`Ctrl F` to find `PDB`

<details>
<summary><b>Answer</b></summary>
C:\Users\HTB\Desktop\argument\Release\argument.pdb
</details>

**The malware author was using a Windows OS. What was the associated username?**
Scroll down to `File Details` section.

<details>
<summary><b>Answer</b></summary>
HTB
</details>

**What calling convention is used in argument_baby_1.exe ?**

```bash
objdump -d [filename]
```

<details>
<summary><b>Answer</b></summary>
cdecl
</details>

**How is the 1st argument passed to the function in argument_baby_1.exe?**
<details>
<summary><b>Answer</b></summary>
esp
</details>

**How is the 2nd argument passed to the function in argument_baby_1.exe?**
<details>
<summary><b>Answer</b></summary>
esp+4
</details>

**How is the 3rd argument passed to the function in argument_baby_1.exe?**
<details>
<summary><b>Answer</b></summary>
esp+8
</details>

**How is the 4th argument passed to the function in argument_baby_1.exe?**
<details>
<summary><b>Answer</b></summary>
esp+c
</details>

**How is the 5th argument passed to the function in argument_baby_1.exe?**
<details>
<summary><b>Answer</b></summary>
esp+10
</details>

**Which CPU register holds the function's return value in argument_baby_1.exe?**
<details>
<summary><b>Answer</b></summary>
eax
</details>

**What calling convention is used in argument_baby_2.exe ?**
<details>
<summary><b>Answer</b></summary>
fastcall
</details>

**How is the 1st argument passed to the function in argument_baby_2.exe?**
<details>
<summary><b>Answer</b></summary>
ecx
</details>

**How is the 2nd argument passed to the function in argument_baby_2.exe?**
<details>
<summary><b>Answer</b></summary>
edx
</details>

**How is the 3rd argument passed to the function in argument_baby_2.exe?**
<details>
<summary><b>Answer</b></summary>
esp
</details>

**How is the 4th argument passed to the function in argument_baby_2.exe?**
<details>
<summary><b>Answer</b></summary>
esp+4
</details>

**How is the 5th argument passed to the function in argument_baby_2.exe?**
<details>
<summary><b>Answer</b></summary>
esp+8
</details>

**What CPU architecture was argument_baby_3.exe compiled for ?**
<details>
<summary><b>Answer</b></summary>
64 bit
</details>

**How is the 1st argument passed to the function in argument_baby_3.exe?**
<details>
<summary><b>Answer</b></summary>
rcx
</details>

**How is the 2nd argument passed to the function in argument_baby_3.exe?**
<details>
<summary><b>Answer</b></summary>
rdx
</details>

**How is the 3rd argument passed to the function in argument_baby_3.exe?**
<details>
<summary><b>Answer</b></summary>
r8
</details>

**How is the 4th argument passed to the function in argument_baby_3.exe?**
<details>
<summary><b>Answer</b></summary>
r9
</details>

**How is the 5th argument passed to the function in argument_baby_3.exe?**
<details>
<summary><b>Answer</b></summary>
rsp+20
</details>

**In the case of argument_baby_3.exe, which CPU register stores the function's return value?**
<details>
<summary><b>Answer</b></summary>
rax
</details>

