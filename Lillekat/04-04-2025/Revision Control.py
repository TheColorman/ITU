N = int(input())
ids = list(map(int, input().split()))

res: list[str] = []

seen: set[int] = set()

for i in ids:
    if i in seen:
        res.append("0")
    else:
        res.append("1")
    seen.add(i)

print(" ".join(res))
