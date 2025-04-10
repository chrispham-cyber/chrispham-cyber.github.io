---
layout: post
title:  "Sekur Julius"
date:   2025-04-01 18:30:00 -0400
categories: HTB-challenge crypto very-easy
tags: HTB CTF writeup python
---

### SOLUTION
Reading source code, we can see:
- The function takes a message (msg) and a shift value (shift).
- If the character is a space, it appends '0' to the ciphertext.
- If the character is not an uppercase letter (A-Z), it appends the character as is.
- If the character is an uppercase letter, it calculates the new character by shifting it within the alphabet using the Caesar cipher logic.

Now we write decrypt code, reverse the formula
```python
import os
def julius_decrypt(ct, shift):
    msg = ''
    for c in ct:
        if c == '0':
            msg += ' '
        elif not ord('A') <= ord(c) <= ord('Z'):
            msg += c
        else:
            o = ord(c) - 65
            msg += chr (65 + (0 - shift) % 26)
    return msg

def decrypt(ct, key):
    for shift in reversed (key):
        ct = julius_decrypt(ct, shift)
    return ct

# Read the encrypted message from output.txt
with open('output.txt', 'r') as f:
    encrypted_msg = f.read()

# Generate the same secure key (this is just for demonstration; in practice, you should store the key securely)
secure_key = os.urandom(1337)

# Convert the secure key to shift values (0-25)
# Here we take the first 26 bytes and map them to shifts
key_shifts = [b % 26 for b in secure_key[:26]]

decrypted_msg = decrypt(encrypted_msg, key_shifts)

print(decrypted_msg)
```

We got the message!
![](/assets/img/htb/sekur julius/2.png)
