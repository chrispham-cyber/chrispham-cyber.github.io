---
layout: post
title:  "Hunting License"
date:   2025-04-10 23:50:00 -0400
categories: HTB-challenge reversing very-easy
tags: HTB CTF writeup 
---

### SOLUTION
**Q1: What is the file format of the executable?**

**Q2: What is the CPU architecture of the executable?**

**Q3: What library is used to read lines for user answers? (`ldd` may help)**

Using `BinaryNinja` to analyze the code. We can answer first 3 questions from the image below.
![](assets/img/htb/hunting license/1.png)

**Q4: What is the address of the `main` function?**

**Q5: How many calls to `puts` are there in `main`? (using a decompiler may help)**

Click on `main` function and get the answer for next 2 questions.
![](assets/img/htb/hunting license/2.png)

**Q6: What is the first password?**

**Q7: What is the reversed form of the second password?**

**Q8: What is the real second password?**

In `main` function, we can see it call `exam()` function. Click on it and we get the answer for next 3  questions.
![](assets/img/htb/hunting license/3.png)

**Q9: What is the XOR key used to encode the third password?** 

**Q10: What is the third password?**

We can see it call `xor()` function here. Click on its parameter to see its value. 
![](assets/img/htb/hunting license/4.png)

![](assets/img/htb/hunting license/5.png)

We get the value, now convert it to `Hex` and `XOR` with `0x13`then we get the flag.
```python
# Input hex string and key
hex_string = "47 7b 7a 61 77 52 7d 77 55 7a 7d 72 32 32 32"
key = 0x13  # Hexadecimal key

# Convert hex string to bytes
bytes_data = bytes.fromhex(hex_string)

# XOR each byte with the key
xor_result = bytes([b ^ key for b in bytes_data])

# Print results
print("XOR Result (Hex):", xor_result.hex())
print("XOR Result (ASCII):", xor_result.decode())
```
