# N = number of ingredients
# M = number of forbidden pairings
# a,b = forbidden pairing

N, M = [int(i) for i in input().split()]

for i in range(M):
    a, b = [int(i) for i in input().split()]
