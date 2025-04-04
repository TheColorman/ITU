n = int(input())

string = input().split()
for i, s in zip(range(1, n + 1), string):
    if s == "mumble":
        continue
    if s == str(i):
        continue
    print("something is fishy")
    exit()
print("makes sense")
