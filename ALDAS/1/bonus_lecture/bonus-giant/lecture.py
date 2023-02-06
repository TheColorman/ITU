import itu.algs4.fundamentals.uf as uf
import sys
import random

n = int(sys.argv[1])

# biggest = 1
sizes = [1] * n

myuf = uf.UF(n)
for i in range(n*n):
    u = random.randrange(n)
    v = random.randrange(n)
    ur = myuf.find(u)
    vr = myuf.find(v)
    su,sv = sizes[ur], sizes[vr]
    if ur != vr:
        myuf.union(u,v)
        newroot = myuf.find(u)
        newsize = sizes[newroot] = su+sv
        if newsize >= n//2:
            print(i+1)
            break