class FenwickTree:
    a: list[int]

    def __init__(self, n: int):
        self.a = [0 for _ in range(n + 1)]

    def get(self, i: int) -> int:
        return self.prefix_sum(i) - self.prefix_sum(i - 1)

    def update(self, i: int, k: int) -> None:
        self.add(i, k - self.get(i))

    def add(self, i: int, k: int) -> None:
        while i < len(self.a):
            self.a[i] += k
            i += i & -i

    def prefix_sum(self, i: int) -> int:
        s = 0
        while i > 0:
            s += self.a[i]
            i -= i & -i
        return s

    def query(self, i: int, j: int) -> int:
        return self.prefix_sum(j) - self.prefix_sum(i - 1)


N, K = map(int, input().strip().split())

ft = FenwickTree(N)

pr: list[int] = []

for _ in range(K):
    q = input().strip().split()
    if q[0] == "F":
        i = int(q[1])
        ft.update(i, not ft.get(i))
    else:
        l, r = map(int, q[1:])
        pr.append(ft.query(l, r))

print("\n".join(map(str, pr)))
