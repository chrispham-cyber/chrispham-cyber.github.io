---
layout: post
title:  "Pivot Chain"
date:   2025-07-04 18:10:00 -0400
categories: HTB-challenge coding easy
tags: HTB CTF writeup 
---

### DESCRIPTION
After successfully leveraging a weak PIN system to access a critical internal server, you've infiltrated CygnusCorp's network.  

Your next objective is clear: pivot laterally toward the Core Administration Server, CygnusCorp’s most sensitive asset. 

The network is heavily monitored by advanced detection systems.

Each pivot path between hosts carries a certain detection risk, based on factors such as traffic visibility, authentication requirements, and known blue team monitoring points.

Your task is to carefully plan your lateral movement to avoid detection.

Use the network map to identify the safest path — the sequence of pivots with the lowest cumulative detection risk — to reach the Core Administration Server from your current compromised host.

Input Format:

• two integers N (number of hosts) and M (number of paths)

• The starting compromised host and the target Core Administration Server.

• A list of M pivot paths between hosts (unidirectional), each with an associated detection risk.

Output Format:

• Print a single integer representing the lowest cumulative detection risk to travel from the starting host to the Core Administration Server. 

5 <= N <= 150000

6 <= M <= 10^6
```
Example:
Input:
5 6 host_1 host_5
host_1 host_2 7
host_2 host_3 6
host_3 host_4 6
host_4 host_5 7
host_5 host_3 11
host_1 host_4 20

Expected output:
26

Output Explanation:
There are 5 hosts and 6 paths between them.
The starting compromised host is host_1 and the target Core Administration Server is host_5.
The optimal route is the following:
(origin -> destination (risk, total cumulative risk))
host_1 -> host_2 (7, total=7)
host_2 -> host_3 (6, total=13)
host_3 -> host_4 (6, total=19)
host_4 -> host_5 (7, total=26)
```

### SOLUTION
```python
import sys, heapq

def find_min_risk():
    input = sys.stdin.readline

    # Read number of nodes, edges, start node, and target node
    N, M, start, target = input().split()
    N, M = int(N), int(M)
    
    graph = {}
    for _ in range(M):
        u, v, w = input().split()
        w = int(w)
        graph.setdefault(u, []).append((v, w))  # directed edge: u -> v
    
    # Distance map: tracks minimum risk from start to each host
    dist = { host: float('inf') for host in graph }
    dist[start] = 0
    
    # Min-heap priority queue: (current_risk_score, current_node)
    pq = [(0, start)]
    while pq:
        curr_risk, u = heapq.heappop(pq)

        # Early exit if target is reached
        if u == target:
            print(curr_risk)
            return

        # Skip if there's already a better path found
        if curr_risk > dist[u]:
            continue

        # Traverse neighbors
        for v, w in graph.get(u, ()):
            new_risk = curr_risk + w
            if new_risk < dist.get(v, float('inf')):
                dist[v] = new_risk
                heapq.heappush(pq, (new_risk, v))

find_min_risk()
```
