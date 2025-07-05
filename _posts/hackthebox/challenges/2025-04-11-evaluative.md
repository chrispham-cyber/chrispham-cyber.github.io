---
layout: post
title:  "Evaluative"
date:   2025-04-11 16:05:00 -0400
categories: HTB-challenge coding very-easy
tags: HTB CTF writeup 
---

### DESCRIPTION
![](assets/img/htb/evaluative/1.png)

### SOLUTION
```python
def evaluate_polynomial(coefficients, x):
    result = 0
    for i, coeff in enumerate(coefficients):
        result += coeff * (x ** i)
    return result

# Read input
coefficients = list(map(int, input().split()))  # Read coefficients as a list of integers
x = int(input())  # Read the value of x

# Calculate the result
value_at_x = evaluate_polynomial(coefficients, x)

# Output the result
print(value_at_x)
```
