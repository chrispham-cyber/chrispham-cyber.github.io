---
layout: post
title:  "Blackwire"
date:   2025-07-04 21:10:00 -0400
categories: HTB-challenge coding medium 
tags: HTB CTF writeup 
---

### DESCRIPTION
A firmware update to a regional power grid controller was intercepted hours after the breach containment at the edge router.

Task Force Phoenix believes this is the next phase of Operation Blackout — a logic bomb embedded deep within the binary.

Mara “Hexor” Bianchi has been assigned to reverse engineer the firmware, and her analysis reveals that the logic bomb operates as a finite state machine.

It starts at state 0, and transitions sequentially through states (0 → 1 → 2 → ... → T) until it reaches a final activation state — at which point the bomb is armed.

The intercepted firmware is a long binary string. The first part contains a transition table, which defines the valid transitions between states.

Each entry in the table is 20 bits long and is structured as follows:

- The first 12 bits represent the current state (S).
- The next 8 bits represent the 8-bit opcode that needs to be executed while in state S, to transition to state S+1.

The remaining part of the binary string contains a sequence of 8-bit opcodes that will be executed in order.

The logic bomb can only progress to the next state if the current state and the opcode match a valid transition in the table.

Crucially, encountering one of these opcodes does not force the bomb to advance to the next state — it merely provides the option to do so.

Your mission is to analyze the firmware and determine how many unique opcode execution paths could cause the logic bomb to progress from state 0 to its final state, by strictly advancing one state at a time.

The input has the following format:

The first line contains two integers, T and L.

T is the number of entries in the transition table, while L is the number of bits after the transition table.

After T transition table entries (T * 20 bits), the next L bits contain the (L / 8) opcodes that will be executed.

3 <= T <= 4000

80 <= L <= 80000

(The answer always fits in a 64-bit unsigned integer.)

```
Example:

Input:
3 240
000000000010110010110000000000000110100000000000000101111000011010000111100011001011011010001010110011100110110001110111100001010001111011011100101100101111111001101110101111000111011110000111100000101111110001111110011011101101010100010101000110101100111011010010111101010001010100011010110011000111

Expected Output:
4

T = 3, L = 240

The 3 transition table entries are embedded in the first part of the data,
with each entry being 20 bits long:
"000000000010110010110000000000000110100000000000000101111000"

Decoding them, we get the transition table entries:
+----------------------------------+
| Current -> Required -> Next      |
| State S    Opcode      State S+1 |
+----------------------------------+
Entry 1: "00000000001011001011":
          ^^^^^^^^^^^^
            State S   ^^^^^^^^
                       Opcode
While in state S, and the required opcode is executed, the logic bomb can transition to state S+1.
State = 000000000010 (binary) = 2 (decimal)
State 2 -> 11001011 -> State 3 (Final State)
When the logic bomb state machine is in state 2, and the opcode 11001011 is encountered it can transition to state 3, which in this case is the final state.

Entry 2: "00000000000001101000":
State 0 -> 01101000 -> State 1

Entry 3: "00000000000101111000":
State 1 -> 01111000 -> State 2

Next we have the remaining binary data, which are the 8-bit opcodes that will be executed:
"011010000111100011001011011010001010110011100110110001110111100001010001111011011100101100101111111001101110101111000111011110000111100000101111110001111110011011101101010100010101000110101100111011010010111101010001010100011010110011000111"

These are the 4 possible execution paths that could lead the logic bomb to trigger:
1) 
01101000 01111000 11001011 01101000 10101100 11100110
S0 -> S1 S1 -> S2 S2 -> S3
11000111 01111000 01010001 11101101 11001011 00101111
11100110 11101011 11000111 01111000 01111000 00101111
11000111 11100110 11101101 01010001 01010001 10101100
11101101 00101111 01010001 01010001 10101100 11000111

2)
01101000 01111000 11001011 01101000 10101100 11100110
S0 -> S1 S1 -> S2
11000111 01111000 01010001 11101101 11001011 00101111
                                    S2 -> S3
11100110 11101011 11000111 01111000 01111000 00101111
11000111 11100110 11101101 01010001 01010001 10101100
11101101 00101111 01010001 01010001 10101100 11000111

3)
01101000 01111000 11001011 01101000 10101100 11100110
S0 -> S1
11000111 01111000 01010001 11101101 11001011 00101111
         S1 -> S2                   S2 -> S3
11100110 11101011 11000111 01111000 01111000 00101111 
11000111 11100110 11101101 01010001 01010001 10101100
11101101 00101111 01010001 01010001 10101100 11000111

4)
01101000 01111000 11001011 01101000 10101100 11100110
                           S0 -> S1
11000111 01111000 01010001 11101101 11001011 00101111
         S1 -> S2                   S2 -> S3
11100110 11101011 11000111 01111000 01111000 00101111 
11000111 11100110 11101101 01010001 01010001 10101100
11101101 00101111 01010001 01010001 10101100 11000111

These are the only execution paths that allow the logic bomb to progress to its final state, therefore the answer is 4.
```

### SOLUTION
```python
from collections import defaultdict, Counter
import sys

def solve_blackwire(T, L, bitstring):
    def bits_to_int(bits):
        return int(bits, 2)

    # Step 1: Parse transition table
    transitions = defaultdict(set)
    for i in range(T):
        start = i * 20
        state = bits_to_int(bitstring[start:start+12])
        opcode = bits_to_int(bitstring[start+12:start+20])
        transitions[state].add(opcode)

    # Step 2: Parse opcodes
    opcodes = []
    opcode_bits_start = T * 20
    for i in range(opcode_bits_start, opcode_bits_start + L, 8):
        byte = bitstring[i:i+8]
        opcodes.append(bits_to_int(byte))

    # Step 3: Dynamic programming
    from collections import Counter
    dp = Counter()
    dp[0] = 1  # Start at state 0

    for op in opcodes:
        next_dp = Counter()
        for s in dp:
            # Option 1: Stay in current state
            next_dp[s] += dp[s]
            # Option 2: Move to s+1 if opcode matches
            if op in transitions[s]:
                next_dp[s + 1] += dp[s]
        dp = next_dp

    # Step 4: Result is number of ways to reach state T
    return dp[T]


T_L_line = sys.stdin.readline().strip()
bitstring_line = sys.stdin.readline().strip()
T, L = map(int, T_L_line.split())
print(solve_blackwire(T, L, bitstring_line))
```
