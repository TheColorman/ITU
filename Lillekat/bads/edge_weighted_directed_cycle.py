"""
The EdgeWeightedDirectedCycle class represents a data type for
determining whether an edge-weighted digraph has a directed cycle.
The hasCycle operation determines whether the edge-weighted
digraph has a directed cycle and, if so, the cycle operation
returns one.
This implementation uses depth-first search.
The constructor takes time proportional to V + E
(in the worst case),
where V is the number of vertices and E is the number of edges.
Afterwards, the hasCycle operation takes constant time;
the cycle operation takes time proportional
to the length of the cycle.
"""

from typing import cast
from .directed_edge import DirectedEdge
from .graph import GenericDiGraph
from .stack import Stack


class EdgeWeightedDirectedCycle:
    """Determines whether the edge-weighted digraph G has a directed cycle and,
    if so, finds such a cycle.

    :param G the edge-weighted digraph

    """

    def __init__(self, G: GenericDiGraph) -> None:
        self._marked: list[bool] = [
            False
        ] * G.V()  # marked[v] = has vertex v been marked?
        self._edgeTo: list[DirectedEdge | None] = [
            None
        ] * G.V()  # edgeTo[v] = previous DirectedEdge on path to v
        self._onStack: list[bool] = [
            False
        ] * G.V()  # onStack[v] = is vertex on the stack?
        self._cycle: Stack[DirectedEdge] | None = (
            None  # directed cycle (or None if no such cycle)
        )

        for v in range(G.V()):
            if not self._marked[v]:
                self._dfs(G, v)

        # check that digraph has a cycle
        assert self._check()

    # check that algorithm computes either the topological order or finds a directed cycle
    def _dfs(self, G: GenericDiGraph, v: int) -> None:
        self._onStack[v] = True
        self._marked[v] = True
        for e in G.adj(v):
            w = e.to_vertex()

            # short circuit if directed cycle found
            if self._cycle is not None:
                return

            # found new vertex, so recur
            elif not self._marked[w]:
                self._edgeTo[w] = e
                self._dfs(G, w)

            # trace back directed cycle
            elif self._onStack[w]:
                self._cycle = Stack()
                f = e
                while f and f.from_vertex() != w:
                    self._cycle.push(f)
                    f = self._edgeTo[f.from_vertex()]

                if f is not None:
                    self._cycle.push(f)
                return
        self._onStack[v] = False

    # Does the edge-weighted digraph have a directed cycle?
    # @return True if the edge-weighted digraph has a directed cycle,
    # False otherwise
    def has_cycle(self) -> bool:
        return self._cycle is not None

    # Returns a directed cycle if the edge-weighted digraph has a directed cycle,
    # and None otherwise.
    # @return a directed cycle (as an iterable) if the edge-weighted digraph
    #    has a directed cycle, and None otherwise
    def cycle(self) -> Stack[DirectedEdge] | None:
        return self._cycle

    # certify that digraph is either acyclic or has a directed cycle
    def _check(self) -> bool:
        # edge-weighted digraph is cyclic
        if self.has_cycle():
            # verify cycle
            first = None
            last = None
            for e in cast(Stack[DirectedEdge], self.cycle()):
                if first is None:
                    first = e
                if last is not None:
                    if last.to_vertex() != e.from_vertex():
                        print("cycle edges {} and {} not incident".format(last, e))
                        return False
                last = e

            if (
                cast(DirectedEdge, last).to_vertex()
                != cast(DirectedEdge, first).from_vertex()
            ):
                print("cycle edges {} and {} not incident".format(last, first))
                return False

        return True


# def main(args):
#     from itu.algs4.stdlib import stdrandom as stdrandom
#
#     # create random DAG with V vertices and E edges; then add F random edges
#     V = int(args[0])
#     E = int(args[1])
#     F = int(args[2])
#     G = EdgeWeightedDigraph(V)
#     vertices = [i for i in range(V)]
#     stdrandom.shuffle(vertices)
#     for _ in range(E):
#         while True:
#             v = stdrandom.uniformInt(0, V)
#             w = stdrandom.uniformInt(0, V)
#             if v >= w:
#                 break
#         weight = stdrandom.uniformFloat(0.0, 1.0)
#         G.add_edge(DirectedEdge(v, w, weight))
#
#     # add F extra edges
#     for _ in range(F):
#         v = stdrandom.uniformInt(0, V)
#         w = stdrandom.uniformInt(0, V)
#         weight = stdrandom.uniformFloat(0.0, 1.0)
#         G.add_edge(DirectedEdge(v, w, weight))
#
#     print(G)
#
#     # find a directed cycle
#     finder = EdgeWeightedDirectedCycle(G)
#     if finder.has_cycle():
#         print("Cycle: ")
#         for e in finder.cycle():
#             print("{}  ".format(e), end="")
#         print()
#     # or give topologial sort
#     else:
#         print("No directed cycle")
#
#
# if __name__ == "__main__":
#     main(sys.argv[1:])
