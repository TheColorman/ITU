import sys
import itu.algs4.fundamentals.uf as uf
import random
from math import log

# theoretical background 
# https://en.wikipedia.org/wiki/Giant_component
# https://bitbucket.org/rikj/bads-labs/downloads/giantbook.pdf

# in wsl
# for n in 100 200 500 1000 10_000 100_000 1000_000 10_000_000; do for t in 3 5 7; do  TIMEFORMAT=".$t $n: %R"; time pypy3 giant.py $n 100 .$t > Out/$t-$n.res; done; done

# in powershell
#> cd \\wsl$\Ubuntu-20.04\home\rikj\WorkSpace\bads-code\bonus-giant
#> python .\myplot.py Out/*-*.res


def giant(n, seed=0,stop_at_giant=False,giant_threshold=.5):
    r = random.Random()
    if seed > 0:
        r.seed(seed)
    # myuf = uf.QuickFindUF(n)
    myuf = uf.UF(n)

    is_isolated = [True]*n
    number_isolated = n
    first_all_non_isolated = 0
    first_giant = 0
    first_one_component = 0

    size = [1]*n
    max_size = 1
    for i in range(n*n):
        u = r.randrange(n)
        v = r.randrange(n)
        
        if is_isolated[u]:
            is_isolated[u] = False
            number_isolated -= 1
        if is_isolated[v]:
            is_isolated[v] = False
            number_isolated -= 1

        if number_isolated <= 1 and first_all_non_isolated==0:
            first_all_non_isolated = i

        if myuf.connected(u,v):
            #print(f'{u} {v} connected')
            continue
        new_size = size[myuf.find(u)]+size[myuf.find(v)]
        myuf.union(u,v)
        # print(f'check {myuf.find(v)}=={myuf.find(u)}')
        size[myuf.find(v)] = new_size
        max_size = max(max_size,new_size)
        # print(f'{i}: {max_size}')
        if max_size >= giant_threshold*n and first_giant==0:
            first_giant = i
            if stop_at_giant:
                break
        if myuf.count() == 1:
            first_one_component = i
            break
    return (first_giant,first_all_non_isolated,first_one_component)

if __name__ == '__main__': 
    n = int(sys.argv[1].replace('_',''))
    if len(sys.argv) == 2:
        print(f'n: {n}')
        g,i,c = giant(n)
        print(f'Seeing a giant component at {g} {g/n:.2}')
        print(f'Everything is connected at {c} {c/n:.2}')
        print(f'All non-isolated at {i} {i/n:.2}')
    else:
        rep = int(sys.argv[2])
        giant_threshold = float(sys.argv[3])  if len(sys.argv) > 3 else .5
        outp = sorted(giant(n,stop_at_giant=True,giant_threshold=giant_threshold)[0]*2/n for i in range(rep))
        print("\n".join(f"{x}" for x in outp))
