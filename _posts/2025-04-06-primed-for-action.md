---
layout: post
title:  "Primed For Action"
date:   2025-04-06 20:30:00 -0400
categories: HTB-challenge misc very-easy
tags: HTB CTF writeup python
---

### DESCRIPTION
Intelligence units have intercepted a list of numbers. They seem to be used in a peculiar way - the adversary seems to be sending a list of numbers, most of which are garbage, but two of which are prime. These 2 prime numbers appear to form a key, which is obtained by multiplying the two.

Your answer is the product of the two prime numbers. Find the key and help us solve the case.

Input: 2 6 7 18 6

Output: 14

### IDEA
First, we need to handle the input by converting it into a list.
```python
n = input()
input_list = list(map(int, n.split()))
```

Next, we need to check if a number is prime.
```python
def is_prime(n):
    if n <= 1:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True
```
Then we find the product of the 2 prime numbers in the list.
```
def find_key(numbers):
    primes = [num for num in numbers if is_prime(num)]
    
    if len(primes) != 2:
        raise ValueError("There should be exactly two prime numbers in the input.")
    
    return primes[0] * primes[1]
```

### SOURCE CODE
Here is the completed code
```python
def is_prime(n):
    if n <= 1:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True

def find_key(numbers):
    primes = [num for num in numbers if is_prime(num)]
    
    if len(primes) != 2:
        raise ValueError("There should be exactly two prime numbers in the input.")
    
    return primes[0] * primes[1]

n = input()
input_list = list(map(int, n.split()))

key = find_key(input_list)
print(key) 
```
