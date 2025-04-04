correct = int(input())
mine = [1 if i == "T" else 0 for i in input()]
friend = [1 if i == "T" else 0 for i in input()]
l = len(mine)
same = sum([a == b for a, b in zip(mine, friend)])

right_for_sure = min(same, correct)
print(right_for_sure + (l - same))
