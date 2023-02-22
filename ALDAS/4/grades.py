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

def mergesort(a, fn=lambda x: (x, x)):
    if len(a) < 2:
        return a
    hi = len(a)
    mi = hi // 2

    L = mergesort(a[0:mi], fn)
    R = mergesort(a[mi:hi], fn)
    mrgd = merge(L, R, fn)
    return mrgd


def merge(L, R, fn):
    n1, n2 = len(L), len(R)
	# Merge the temp arrays back into arr[l..r]
    i = 0	 # Initial index of first subarray
    j = 0	 # Initial index of second subarray

    new = []
    # Look at smallest in each array and add it to new
    while i < n1 and j < n2:
        a = L[i]
        b = R[j]


        if fn(a)[0] < fn(b)[0]:
            new.append(a)
            i += 1
        elif fn(a)[0] > fn(b)[0]:
            j += 1
            new.append(b)
        else:
            # equal, secondary sort
            if fn(a)[1] <= fn(b)[1]:
                new.append(a)
                i += 1
            elif fn(a)[1] > fn(b)[1]:
                j += 1
                new.append(b)

    if i < n1:
        new.extend(L[i:n1])
    if j < n2:
        # print(j, n1, R, R[j:n1])
        new.extend(R[j:n2])
        
    return new

# a = [(0, 1), (0, 0), (0, -1), (0, -2), (0, -3), (0, -4), (0, 1)]
# print(a)
# mergesort(a, lambda x: (x[0], x[1]))
    

# sorted_students = sorted(students, key=lambda vertex: (vertex[1], vertex[0]))
sorted_students = mergesort(students, fn=lambda x: (x[1], x[0]))
# print(students)
# print(sorted_students)
[print(name) for name, grade in sorted_students]
