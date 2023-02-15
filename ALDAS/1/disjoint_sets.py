# from itu.algs4.fundamentals.uf import UF
from itu.algs4.stdlib.stdio import readInt, writeln

class UnionFind:
    parent = []

    def __init__(self, n: int) -> None:
        self.parent = [i for i in range(n)]
    
    def find(self, p: int) -> int:
        """Find root of node p"""
        p_parent = self.parent[p]
        while p_parent != self.parent[p_parent]:
            p_parent = self.parent[p_parent]
        self.parent[p] = p_parent
        
        return p_parent

    def query(self, p: int, q: int) -> bool:
        """Query whether two nodes are connected"""
        p_root = self.find(p)
        q_root = self.find(q)

        return p_root == q_root

    def height(self, p: int) -> int:
        """Get height of a tree where node p is a member"""
        pass # Not implemented

    def union(self, p: int, q: int) -> None:
        """Connect two nodes."""
        p_root = self.find(p)
        q_root = self.find(q)
        if (p_root == q_root):
            return

        self.parent[p_root] = q_root # TODO: Weigh union based on tree height
    
    def move(self, p: int, q: int) -> int:
        """Moves element p into the set containing element q and returns the root"""
        p_root = self.find(p)
        q_root = self.find(q)
        if p_root == q_root:
            return
        # Find all elements pointing to p and point them instead to the parent of p
        # If the parent of p is p, make the first one the new parent and point all others to it
        p_parent = self.parent[p]
        new_parent = p_parent
        for i in range(len(self.parent)):
            if self.parent[i] == p:
                if new_parent == p:
                    new_parent = i
                self.parent[i] = new_parent
        
        # Point p to q
        self.parent[p] = q_root
        return q_root

n, m = readInt(), readInt()
uf = UnionFind(n)
operations = [[readInt() for i in range(3)] for _ in range(m)]

for operation in operations:
    if operation[0] == 0:
        result = uf.query(operation[1], operation[2])
        if result:
            print(1)
        else:
            print(0)
    elif operation[0] == 1:
        uf.union(operation[1], operation[2])
    elif operation[0] == 2:
        uf.move(operation[1], operation[2])