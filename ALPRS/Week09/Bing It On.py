from collections import defaultdict


class Node:
    def __init__(self):
        self.children: dict[str, Node] = defaultdict(lambda: Node())
        self.count: int = 0


class Trie:
    def __init__(self):
        self.root: Node = Node()

    def insert(self, string: str):
        current = self.root

        for char in string:
            current.count += 1
            current = current.children[char]
        current.count += 1
        return current.count - 1


N = int(input())
T = Trie()

buffer: list[int] = []
for _ in range(N):
    word = input().strip()
    buffer.append(T.insert(word))

print("\n".join(map(str, buffer)))
