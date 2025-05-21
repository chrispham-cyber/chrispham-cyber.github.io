---
layout: post
title:  "Deterministic"
date:   2025-04-28 16:30:00 -0400
categories: HTB-challenge misc easy
tags: HTB CTF writeup python xor
---

### CHALLENGE DESCRIPTION
There is a locked door in front of us that can only be opened with the secret passphrase. There are no keys anywhere in the room, only this .txt. There is also a writing on the wall.. `State 0: 69420, State N: 999, flag ends at state N, key length: one`.. Can you figure it out and open the door?

### SOLUTION
We need to find the path from the beginning state to the end state.

```python
from collections import defaultdict, deque

# Set start and end states
start_state = 69420
end_state = 999

# Build the graph
graph = defaultdict(list)

# Open and parse the file
with open('deterministic.txt', 'r') as f:
    for line in f:
        parts = line.strip().split()
        if len(parts) == 3:
            current_state = int(parts[0])
            input_char = parts[1]
            next_state = int(parts[2])
            graph[current_state].append((input_char, next_state))

# BFS to find the path
def bfs(start, end):
    queue = deque()
    queue.append((start, []))  # (current_state, path_so_far)
    visited = set()

    while queue:
        current_state, path = queue.popleft()
        if current_state in visited:
            continue
        visited.add(current_state)

        if current_state == end:
            return path

        for input_char, next_state in graph.get(current_state, []):
            queue.append((next_state, path + [input_char]))
    return None

# Find the path
path = bfs(start_state, end_state)

if path:
    flag = ' '.join(path)
    print("Output:", flag)
else:
    print("No path found from start to end.")
```

Now we have the output, copy the output to `CyberChef`, convert from `Decimal` to `Ascii`
![](assets/img/htb/deterministic/1.png)

We know the special key, now `XOR` it and we get the flag.
![](assets/img/htb/deterministic/2.png)
