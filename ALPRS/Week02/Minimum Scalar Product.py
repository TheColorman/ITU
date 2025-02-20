import numpy as np

T = int(input())

for i in range(T):
    n = int(input())
    v1 = sorted([int(i) for i in input().split()])
    v2 = sorted([int(i) for i in input().split()], reverse=True)

    s = np.dot(v1, v2)
    print(f"Case #{i+1}: {s}")
