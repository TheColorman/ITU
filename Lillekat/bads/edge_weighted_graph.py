from typing import override

from .graph import GenericGraph
from .edge import Edge
from .stack import Stack
from .bag import Bag
from .errors import IllegalArgumentException


class EdgeWeightedGraph(GenericGraph):
    """The EdgeWeightedGraph class represents an edge-weighted graph of
    vertices named 0 through V-1, where each undirected edge is of type Edge
    and has a real-valued weight.

    It supports the following two primary operations: add an edge to the
    graph, iterate over all of the edges incident to a vertex. It also
    provides methods for returning the number of vertices V and the
    number of edges E. Parallel edges and self-loops are permitted. By
    convention, a self-loop v-v appears in the adjacency list of v twice
    and contributes two to the degree of v. This implementation uses an
    adjacency-list representation, which is a vertex-indexed array of
    Bag objects. All operations take constant time (in the worst case)
    except iterating over the edges incident to a given vertex, which
    takes time proportional to the number of such edges.

    """

    def __init__(self, V: int) -> None:
        """Initializes an empty edge-weighted graph with V vertices and 0
        edges.

        :param V: the number of vertices
        :raises IllegalArgumentException: if V < 0

        """
        if V < 0:
            raise IllegalArgumentException("Number of vertices must be nonnegative")
        self._V: int = V
        self._e: int = 0
        self._adj: list[Bag[Edge] | None] = [None] * V
        for v in range(V):
            self._adj[v] = Bag()

    @staticmethod
    def from_graph(G: GenericGraph) -> "EdgeWeightedGraph":
        """Initializes a new edge-weighted graph that is a deep copy of G.

        :param G: the edge-weighted graph to copy
        :return: the copy of the graph edge-weighted graph G
        :rtype: EdgeWeightedGraph

        """
        g = EdgeWeightedGraph(G.V())
        g._e = G.E()
        for v in range(G.V()):
            reverse = Stack[Edge]()
            for e in G.adj(v):
                reverse.push(e)
            for e in reverse:
                g._adj[v].add(e)  # pyright: ignore[reportOptionalMemberAccess]
        return g

    def add_edge(self, e: Edge) -> None:
        """Adds the undirected edge e to this edge-weighted graph.

        :param e: the edge

        """
        v = e.either()
        w = e.other(v)
        self._validate_vertex(v)
        self._validate_vertex(w)
        adjv = self._adj[v]
        if adjv is not None:
            adjv.add(e)
        adjw = self._adj[w]
        if adjw is not None:
            adjw.add(e)
        self._e += 1

    @override
    def adj(self, v: int) -> Bag[Edge]:
        """Returns the edges incident on vertex v.

        :param v: the vertex
        :return: the edges incident on vertex v
        :rtype: collections.iterable[Edge]

        """
        self._validate_vertex(v)
        return self._adj[v]  # pyright: ignore[reportReturnType]

    @override
    def V(self) -> int:
        """Returns the number of vertices in this edge-weighted graph.

        :return: the number of vertices in this edge-weighted graph
        :rtype: int

        """
        return self._V

    @override
    def E(self) -> int:
        """Returns the number of edges in this edge-weighted graph.

        :return: the number of edges in this edge-weighted graph
        :rtype: int

        """
        return self._e

    def degree(self, v: int) -> int:
        """Returns the degree of vertex v.

        :param v: the vertex
        :return: the degree of vertex v
        :rtype: int
        :raises IllegalArgumentException: unless 0 <= v < V

        """
        self._validate_vertex(v)
        return self._adj[v].size()  # pyright: ignore[reportOptionalMemberAccess]

    @override
    def edges(self) -> Bag[Edge]:
        """Returns all edges in this edge-weighted graph.

        :return: all edges in this edge-weighted graph

        """
        edges = Bag[Edge]()
        for v in range(self._V):
            self_loops = 0
            for e in self.adj(v):
                if e.other(v) > v:
                    edges.add(e)
                elif e.other(v) is v:
                    if self_loops % 2 == 0:
                        edges.add(e)
                    self_loops += 1
        return edges

    def _validate_vertex(self, v: int) -> None:
        """Raises an IllegalArgumentException unless 0 <= v < V.

        :param v: the vertex to be validated

        """
        if v < 0 or v >= self._V:
            raise IllegalArgumentException(
                "vertex {} is not between 0 and {}".format(v, self._V - 1)
            )

    @override
    def __repr__(self) -> str:
        """Returns a string representation of the edge-weighted graph.

        This method takes time proportional to E + V.
        :return: the number of vertices, followed by the number of edges,
        followed by the V adjacency lists of edges

        """
        s = ["{} {} \n".format(self._V, self._e)]
        for v in range(self._V):
            s.append("{}: ".format(v))
            adj = self._adj[v]
            if adj is not None:
                for e in adj:
                    s.append("{}: ".format(e))
            s.append("\n")
        return "".join(s)


# def main():
#     """Creates an edge-weighted graph from the given input file and prints
#     it."""
#     if len(sys.argv) > 1:
#         stream = InStream(sys.argv[1])
#         G = EdgeWeightedGraph.from_stream(stream)
#         print(G)
#
#
# if __name__ == "__main__":
#     main()
