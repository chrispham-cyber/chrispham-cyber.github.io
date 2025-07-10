import re
from collections import Counter

with open('/var/log/nginx/access.log') as f:
    logs = f.readlines()

ip_counts = Counter()
for line in logs:
    match = re.match(r'(\d+\.\d+\.\d+\.\d+)', line)
    if match:
        ip_counts[match.group(1)] += 1

for ip, count in ip_counts.most_common(10):
    print(f"{ip}: {count} requests")
