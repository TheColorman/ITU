from random import randint


n = randint(1, 100000)
print(n)
print(f"{1}:")
for i in range(2, n + 1):
    dep_count = randint(0, 5)
    deps: list[str] = []
    for _ in range(dep_count):
        d = None
        while d in deps or d is None:
            d = str(randint(i + 1, 100000))
        deps.append(d)
    format = f"{i}: {' '.join(deps)}"
    print(format.strip())

print(randint(1, 100000))
