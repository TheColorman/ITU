import itertools
from itu.algs4.sorting.merge import sort

grad = {
    "F": 126,
    "FX": 105,
    "E": 84,
    "D": 63,
    "C": 42,
    "B": 21,
    "A": 0,
}

n = int(input())

students = [input().strip().split(" ") for _ in range(n)]

for i in range(len(students)):
    name, grade = students[i]
    meta = ["".join(x) for _, x in itertools.groupby(grade, key=lambda x: x in "+-")]
    baseval = grad[meta[0]]
    if len(meta) > 1:
        for char in meta[1]:
            if char == "+":
                baseval -= 1
            elif char == "-":
                baseval += 1
    students[i] = (name, baseval)

sorted_students = sorted(students, key=lambda vertex: (vertex[1], vertex[0]))
[print(name) for name, grade in sorted_students]

sort(sorted_students)
print(sorted_students)