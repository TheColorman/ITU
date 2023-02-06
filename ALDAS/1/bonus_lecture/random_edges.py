# random_edges.py
# Runs unionfind until a component is connected, with n nodes. 
#   giant_component: more than 50% nodes in 1 component.
#   nonisolated: no isolated nodes, aka. all nodes are connected to at least 1 other node.
#   connected: all nodes connected to same component. 

import random
import itu.algs4.fundamentals.uf as uf

n = 1000000

myuf = uf.WeightedQuickUnionUF(n)
sizes = [1] * n
have_giant = False
non_isolated = False
connected = False
number_isolated = n

i = 0
while True:
    i += 1
    u = random.randrange(n)
    v = random.randrange(n)
    ur = myuf.find(u)
    vr = myuf.find(v)


    if sizes[ur] == 1:
        number_isolated -= 1
    if sizes[vr] == 1 and vr != ur:
        number_isolated -= 1


    if ur == vr:
        continue
    
    ## add edge
    myuf.union(ur, vr)
    uur = myuf.find(ur)
    news = sizes[uur] = sizes[ur] + sizes[vr]

    ## check if isolated
    if number_isolated == 0 and not non_isolated:
        non_isolated = True
        print(f"non-isolated at {i/n:.2f}")
    
    if news >= n//2 and not have_giant:
        have_giant = True
        print(f"giant at {i/n:.2f}")
    
    if myuf.count() == 1 and not connected:
        connected = True
        print(f"connected at {i/n:.2f}")
        break