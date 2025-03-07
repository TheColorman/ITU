# BFS
# Keep track of current color and next. If at any point something doesn't add up, exit 0.
# Otherwise, exit 1.
# Imports
from typing import Generic, Iterator, List, Optional, TypeVar

T = TypeVar("T")

class Node(Generic[T]):
    def __init__(self, item: T, next: Optional["Node[T]"]) -> None:
        """Initializes a new node.
        :param item: the item to be stored in the node
        :param next: the next node in the queue
        """
        self.item: T = item
        self.next: Optional[Node[T]] = next
 
class Queue(Generic[T]):
    """The Queue class represents a first-in-first-out (FIFO) queue of generic
    items.
    It supports the usual enqueue and dequeue operations, along with
    methods for peeking at the first item, testing if the queue is
    empty, and iterating through the items in FIFO order This
    implementation uses a singly linked list of linked-list nodes The
    enqueue, dequeue, peek, size, and is_empty operations all take
    constant time in the worst case
    """

    def __init__(self) -> None:
        """Initializes an empty queue."""
        self._first: Optional[Node[T]] = None
        self._last: Optional[Node[T]] = None
        self._n: int = 0

    def enqueue(self, item: T) -> None:
        """Adds the item to this queue.
        :param item: the item to add
        """
        old_last: Optional[Node[T]] = self._last
        self._last = Node(item, None)
        if self.is_empty():
            self._first = self._last
        else:
            assert old_last is not None
            old_last.next = self._last
        self._n += 1

    def dequeue(self) -> T:
        """
        Removes and returns the item on this queue that was least recently added.
        :return: the item on this queue that was least recently added.
        :raises NoSuchElementException: if this queue is empty
        """
        if self.is_empty():
            raise Exception()

        assert self._first is not None
        item = self._first.item
        self._first = self._first.next
        self._n -= 1
        if self.is_empty():
            self._last = None
        return item

    def is_empty(self) -> bool:
        """Returns true if this queue is empty.
        :return: True if this queue is empty otherwise False
        :rtype: bool
        """
        return self._first is None

    def size(self) -> int:
        """Returns the number of items in this queue.
        :return: the number of items in this queue
        :rtype: int
        """
        return self._n

    def __len__(self) -> int:
        return self.size()

    def peek(self) -> T:
        """
        Returns the item least recently added to this queue.
        :return: the item least recently added to this queue
        :raises NoSuchElementException: if this queue is empty
        """
        if self.is_empty():
            raise Exception()

        assert self._first is not None
        return self._first.item

    def __iter__(self) -> Iterator[T]:
        """Iterates over all the items in this queue in FIFO order."""
        curr = self._first
        while curr is not None:
            yield curr.item
            curr = curr.next

    def __repr__(self) -> str:
        """Returns a string representation of this queue.
        :return: the sequence of items in FIFO order, separated by spaces
        """
        s = []
        for item in self:
            s.append("{} ".format(item))
        return "".join(s)

V, E = [int(i) for i in input().split(" ")]
edges = [(int(u), int(v), bool(int(c))) for u, v, c in [input().split(" ") for _ in range(E)]]

class Edge:
    def __init__(self, fro: int, to: int, conflict_edge: bool) -> None:
        self.fro = fro
        self.to = to
        self.conflict_edge = conflict_edge
    
    def __repr__(self) -> str:
        return f"{self.fro}-{self.to}:{self.conflict_edge}"

    def __str__(self) -> str:
        return self.__repr__()

class Graph:
    def __init__(self, V: int) -> None:
        self._adj: list[list[Edge]] = [[] for _ in range(V)]
    
    def add_edge(self, v: int, w: int, c: bool):
        edgeA = Edge(v, w, c)
        edgeB = Edge(w, v, c)
        self._adj[v].append(edgeA)
        self._adj[w].append(edgeB)
    
    def adj(self, v: int):
        return self._adj[v]
    
    def __repr__(self) -> str:
        return self._adj.__repr__()


graph = Graph(V)
[graph.add_edge(v, w, c) for v, w, c in edges]
harmonious = True
# List of colors, or None of not yet marked
# Colors are bools for easy assignment
marked = [None for i in range(V)]
q = Queue()
q.enqueue(0)
marked[0] = True
while not q.is_empty() and harmonious:
    v = q.dequeue()
    current_color = marked[v] # Update current color
    for e in graph.adj(v):
        # Check all adjacent edges
        w = e.to
        if not marked[w] is None: # w is already marked, make sure color between v and w matches whether e is a conflict edge
                                  # curret_color is v's color, marked[w] is w's color.
            if e.conflict_edge and (current_color == marked[w]): # conflict edge, so colors have to be different
                harmonious = False
                break
            if (not e.conflict_edge) and (current_color != marked[w]): # harmony edge, so colors have to be the same
                harmonious = False
                break
            continue # All good, next loop
        q.enqueue(w) # Enqueue w and set its color based on edge type
        if e.conflict_edge:
            marked[w] = not current_color # this is why I used a bool
        else:
            marked[w] = current_color
print(int(harmonious))