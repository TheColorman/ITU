from itu.algs4.sorting.max_pq import MaxPQ

def quotient(v: int, s: int) -> float:
    return v/(s+1)

n, m = [int(i) for i in input().split(" ")]
V = [int(input()) for _ in range(n)]

class PQ:
    def __init__(self) -> None:
        self.l = [None]
        self.size = 0

    def insert(self, item):
        self.l.append(item)
        self.size += 1
        self.swim(self.size)
    
    def remove(self):
        item = self.l[1]
        self.l[1], self.l[self.size] = self.l[self.size], self.l[1]
        self.size -= 1
        self.sink(1)
        del self.l[-1]
        return item
    
    def swim(self, i: int):
        item = self.l[i]
        parent = self.l[i//2]
        while not parent == None and item > parent:
            print(item, parent)
            self.l[i], self.l[i//2] = self.l[i//2], self.l[i]
            item, parent = self.l[i], self.l[i//2]
    
    def sink(self, i):
        item = self.l[i]
        children = self.l[2*i:2*i+2]
        while any([child > item for child in children]):
            # switch with largest child
            if children[0] > item:
                self.l[i], self.l[2*i] = self.l[2*i], self.l[i]
            else:
                self.l[i], self.l[2*i+1] = self.l[2*i+1], self.l[i]
            
            item = self.l[i]
            children = self.l[2*i:2*i+2]
    def __str__(self) -> str:
        return self.l.__str__()
    
seats = {p: 0 for p in range(n)}

pq = MaxPQ()

class quoq:
    def __init__(self, party, quotient) -> None:
        self.p = party
        self.q = quotient
    
    def __eq__(self, __o: object) -> bool:
        return self.q == __o.q
    def __ne__(self, __o: object) -> bool:
        return self.q != __o.q
    def __lt__(self, __o: object) -> bool:
        return self.q < __o.q
    def __gt__(self, __o: object) -> bool:
        return self.q > __o.q
    def __le__(self, __o: object) -> bool:
        return self.q <= __o.q
    def __ge__(self, __o: object) -> bool:
        return self.q >= __o.q
    
    def __str__(self) -> str:
        return f"P: {self.p}, Seats: {seats[self.p]}"

[pq.insert(quoq(i, quotient(V[i], 0))) for i in range(n)]

for i in range(m):
    biggest = pq.del_max()
    seats[biggest.p] += 1
    pq.insert(quoq(biggest.p, quotient(V[biggest.p], seats[biggest.p])))

res = [0 for _ in range(n)]
for i in pq:
    res[i.p] = seats[i.p]

[print(i) for i in res]