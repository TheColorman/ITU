from typing import cast, override

from .graph import GenericDiGraph
from .errors import IllegalArgumentException
from .directed_edge import DirectedEdge
from .bag import Bag
from .stack import Stack


class EdgeWeightedDigraph(GenericDiGraph):
    """The EdgeWeightedDigraph class represents an edge-weighted digraph of
    vertices named 0 through V-1, where each directed edge is of type
    DirectedEdge and has a real-valued weight.

    It supports the following two primary operations: add a directed
    edge to the digraph and iterate over all edges incident from a given
    vertex. it also provides methods for returning the number of
    vertices V and the number of edges E. Parallel edges and self-loops
    are permitted. This implementation uses an adjacency-lists
    representation, which is a vertex-indexed array of Bag objects. All
    operations take constant time (in the worst case) except iterating
    over the edges incident from a given vertex, which takes time
    proportional to the number of such edges.

    """

    def __init__(self, V: int) -> None:
        """Initializes an empty edge-weighted digraph with V vertices and 0
        edges.

        :param V: the number of vertices
        :raises IllegalArgumentException: if V < 0

        """
        if V < 0:
            raise IllegalArgumentException(
                "Number of vertices in a Digraph must be nonnegative"
            )
        self._V: int = V
        self._e: int = 0
        self._indegree: list[int] = [0] * V
        self._adj: list[Bag[DirectedEdge] | None] = [None] * V
        for v in range(V):
            self._adj[v] = Bag[DirectedEdge]()

    @staticmethod
    def from_graph(G: GenericDiGraph) -> "EdgeWeightedDigraph":
        """Initializes a new edge-weighted digraph that is a deep copy of G.

        :param G: the edge-weighted digraph to copy
        :return: a copy of graph G
        :rtype: EdgeWeightedDigraph

        """
        g = EdgeWeightedDigraph(G.V())
        g._e = G.E()
        for v in range(G.V()):
            g._indegree[v] = G.indegree(v)
            reverse: Stack[DirectedEdge] = Stack()
            for e in G.adj(v):
                reverse.push(e)
            for e in reverse:
                cast(Bag[DirectedEdge], g._adj[v]).add(e)
        return g

    @override
    def V(self) -> int:
        """Returns the number of vertices in this edge-weighted digraph.

        :return: the number of vertices in this edge-weighted digraph
        :rtype: int

        """
        return self._V

    @override
    def E(self) -> int:
        """Returns the number of edges in this edge-weighted digraph.

        :return: the number of edges in this edge-weighted digraph
        :rtype: int

        """
        return self._e

    def _validate_vertex(self, v: int) -> None:
        """Raises an IllegalArgumentException unluess 0 <= v < V.

        :param v: the vertex to validate

        """
        if v < 0 or v >= self._V:
            raise IllegalArgumentException(
                "vertex {} is not between 0 and {}".format(v, self._V - 1)
            )

    def add_edge(self, e: DirectedEdge) -> None:
        """Adds the directed edge e to this edge-weighted digraph.

        :param e: the edge
        :raises IllegalArgumentException: unless endpoints of edge are between 0 and V-1

        """
        v = e.from_vertex()
        w = e.to_vertex()
        self._validate_vertex(v)
        self._validate_vertex(w)
        cast(Bag[DirectedEdge], self._adj[v]).add(e)
        self._indegree[w] += 1
        self._e += 1

    @override
    def adj(self, v: int) -> Bag[DirectedEdge]:
        """Returns the directed edges incident from vertex v.

        :param v: the vertex
        :return: the directed edges incident from vertex v.
        :rtype: collections.iterable[DirectedEdge]
        :raises IllegalArgumentException: unless 0 <= v < V

        """
        self._validate_vertex(v)
        return self._adj[v]  # pyright: ignore[reportReturnType]

    def outdegree(self, v: int) -> int:
        """Returns the number of directed edges incident from vertex v. This is
        known as the outdegree of vertex v.

        :param v: the vertex
        :return: the outdegree of vertex v
        :rtype: int
        :raises IllegalArgumentException: unless 0 <= v < V

        """
        self._validate_vertex(v)
        return cast(Bag[DirectedEdge], self._adj[v]).size()

    @override
    def indegree(self, v: int) -> int:
        """Returns the number of directed edges incident to vertex v. This is
        known as the indegree of vertex v.

        :param v: the vertex
        :return: the indegree of vertex v
        :rtype: int
        :raises IllegalArgumentException: unless 0 <= v < V

        """
        self._validate_vertex(v)
        return self._indegree[v]

    @override
    def edges(self) -> Bag[DirectedEdge]:
        """Returns all directed edges in this edge-weighted digraph.

        :return: all edges in this edge-weighted digraph
        :rtype: collections.iterable[DirectedEdge]

        """
        edges = Bag[DirectedEdge]()
        for v in range(self._V):
            for e in cast(Bag[DirectedEdge], self._adj[v]):
                edges.add(e)
        return edges

    @override
    def __repr__(self) -> str:
        """Returns a string representation of this edge-weighted digraph.

        :return: the number of vertices V, followed by the number of edges E,
        followed by the V adjacency lists of edges.
        :rtype: str

        """
        s = ["{} {} \n".format(self._V, self._e)]
        for v in range(self._V):
            s.append("{}: ".format(v))
            for e in cast(Bag[DirectedEdge], self._adj[v]):
                s.append("{}  ".format(e))
            s.append("\n")
        return "".join(s)


# def main():
#     """Creates an edge-weighted digraph from the given input file and prints
#     it."""
#     if len(sys.argv) > 1:
#         stream = InStream(sys.argv[1])
#         G = EdgeWeightedDigraph.from_stream(stream)
#         print(G)
#
#
# if __name__ == "__main__":
#     main()
