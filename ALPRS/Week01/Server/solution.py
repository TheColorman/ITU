n, T = [int(i) for i in input().split()]
ts = [int(i) for i in input().split()]

s = 0
for i in range(n):
    t = ts[i]
    s += t
    if s > T:
        print(i)
        exit()
print(n)
