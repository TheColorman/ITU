from collections.abc import Iterator
from typing import override


class Bag[T]:
    """The Bag class represents a bag (or multiset) of generic items. It
    supports insertion and iterating over the items in arbitrary order.

    This implementation uses a singly linked list with a static nested class Node.
    See LinkedBag for the version from the
    textbook that uses a non-static nested class.

    The add, is_empty, and size operations
    take constant time. Iteration takes time proportional to the number of items.

    """

    class Node[S]:
        # helper linked list class
        def __init__(self):
            self.next: Bag.Node[T] | None = None
            self.item: S | None = None

    def __init__(self) -> None:
        """Initializes an empty bag."""
        self._first: Bag.Node[T] | None = None  # beginning of bag
        self._n: int = 0  # number of elements in bag

    def is_empty(self) -> bool:
        """Returns true if this bag is empty.

        :returns: true if this bag is empty
                  false otherwise

        """
        return self._first is None

    def size(self) -> int:
        """Returns the number of items in this bag.

        :returns: the number of items in this bag

        """
        return self._n

    def __len__(self) -> int:
        return self.size()

    def add(self, item: T) -> None:
        """Adds the item to this bag.

        :param item: the item to add to this bag

        """
        oldfirst = self._first
        self._first = Bag.Node()
        self._first.item = item
        self._first.next = oldfirst
        self._n += 1

    def __iter__(self) -> Iterator[T]:
        """Returns an iterator that iterates over the items in this bag in
        arbitrary order.

        :returns: an iterator that iterates over the items in this bag in arbitrary order

        """
        current = self._first
        while current is not None:
            assert current.item is not None
            yield current.item
            current = current.next

    @override
    def __repr__(self) -> str:
        out = "{"
        for elem in self:
            out += "{}, ".format(elem)
        return out + "}"


# # start of the script itself
# if __name__ == "__main__":
#     import sys
#
#     from itu.algs4.stdlib import stdio
#
#     if len(sys.argv) > 1:
#         try:
#             sys.stdin = open(sys.argv[1])
#         except IOError:
#             print("File not found, using standard input instead")
#
#     bag: Bag[str] = Bag()
#     while not stdio.isEmpty():
#         item = stdio.readString()
#         bag.add(item)
#
#     stdio.writef("size of bag = %i\n", bag.size())
#
#     for s in bag:
#         stdio.writeln(s)
