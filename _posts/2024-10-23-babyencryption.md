---
layout: post
title:  "BabyEncryption"
date:   2024-10-23 18:30:00 -0400
categories: HTB-challenge crypto very-easy
tags: HTB CTF writeup
---

### CHALLENGE DESCRIPTION
You are after an organised crime group which is responsible for the illegal weapon market in your country. As a secret agent, you have infiltrated the group enough to be included in meetings with clients. During the last negotiation, you found one of the confidential messages for the customer. It contains crucial information about the delivery. Do you think you can decrypt it?

```
msg.enc
6e0a9372ec49a3f6930ed8723f9df6f6720ed8d89dc4937222ec7214d89d1e0e352ce0aa6ec82bf622227bb70e7fb7352249b7d893c493d8539dec8fb7935d490e7f9d22ec89b7a322ec8fd80e7f8921
```

### SOLUTION 
To decrypt the message that was encrypted using the provided encryption function, we need to reverse the encryption process. The encryption function applies a linear transformation to each character in the message, specifically:

`ct = (123 \times \text{char} + 18) \mod 256`

To decrypt, we need to find the inverse of this transformation. The decryption process can be broken down into the following steps:

- Subtract 18 from the ciphertext value.
- Multiply by the modular inverse of 123 modulo 256.

### Finding the Modular Inverse
To find the modular inverse of 123 modulo 256, we can use the Extended Euclidean Algorithm. The modular inverse ( x ) of ( a ) modulo ( m ) satisfies:

`a \times x \equiv 1 \mod m`

```python
def modular_inverse(a, m):
    # Extended Euclidean Algorithm to find the modular inverse
    m0, x0, x1 = m, 0, 1
    if m == 1:
        return 0
    while a > 1:
        # q is quotient
        q = a // m
        m, a = a % m, m
        x0, x1 = x1 - q * x0, x0
    if x1 < 0:
        x1 += m0
    return x1

def decryption(ct):
    # Find the modular inverse of 123 mod 256
    inv_123 = modular_inverse(123, 256)
    
    pt = []
    for c in ct:
        # Reverse the encryption formula
        original_char = (inv_123 * (c - 18)) % 256
        pt.append(original_char)
    
    return bytes(pt)

with open('./msg.enc', 'r') as f:
    hex_data = f.read().strip()

ct = bytes.fromhex(hex_data)

decrypted_msg = decryption(ct)

print("Decrypted Message:", decrypted_msg.decode('latin-1'))  
# Use 'latin-1' to handle byte values correctly
```
