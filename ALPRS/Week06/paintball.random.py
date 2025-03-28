from random import randint


N = randint(2, 1000)
M = randint(0, 5000)

for i in range(M):
    A = randint(1, N - 1)
    B = randint(A, N)

    print(A, B)
