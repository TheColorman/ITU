T = int(input())


def badness(ranks):
    return sum(abs(i + 1 - r) for i, r in enumerate(ranks))


for i in range(T):
    input()
    N = int(input())
    teams = sorted([int(input().split()[1]) for _ in range(N)])
    bad = badness(teams)
    print(bad)
