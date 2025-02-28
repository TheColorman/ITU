from collections import defaultdict

# Number of Makefile rules
n = int(input())

G: defaultdict[str, list[str]] = defaultdict(list)

for _ in range(n):
    rule = input().split(":")
    file = rule[0]
    if len(rule) == 1:
        continue

    deps = rule[1].strip().split()
    for dep in deps:
        G[dep].append(file)

changed = input()


# Calculate nodes reachable from `changed`
def bfs(n: str):
    S: list[str] = [n]
    Q: list[str] = [n]

    while Q:
        curr = Q.pop()
        for m in G[curr]:
            if m not in S:
                S.append(m)
                Q.insert(0, m)

    return S


reachable = bfs(changed)

print("\n".join(reachable))
