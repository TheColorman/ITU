from Lillekat.bads.bellman_ford_sp import BellmanFordSP
from Lillekat.bads.directed_edge import DirectedEdge
from Lillekat.bads.edge_weighted_digraph import EdgeWeightedDigraph


while True:
    h, w = map(int, input().split())
    if h == 0 and w == 0:
        break
    block = EdgeWeightedDigraph(h * w + 2)  # add source and target
    all_weights: list[list[int]] = []
    prev_weights = list(map(int, list(input())))

    all_weights.append(prev_weights)

    for row in range(1, h):
        current_weights = list(map(int, list(input())))
        all_weights.append(current_weights)

        for col in range(1, w + 1):
            this = row * w + col
            # Up left
            if col > 1:
                up_left = (row - 1) * w + col - 1
                block.add_edge(DirectedEdge(up_left, this, prev_weights[col - 2]))
                block.add_edge(DirectedEdge(this, up_left, current_weights[col - 1]))

            # Up
            up = (row - 1) * w + col
            block.add_edge(DirectedEdge(up, this, prev_weights[col - 1]))
            block.add_edge(DirectedEdge(this, up, current_weights[col - 1]))

            # Up right
            if col < w:
                up_right = (row - 1) * w + col + 1
                block.add_edge(DirectedEdge(up_right, this, prev_weights[col]))
                block.add_edge(DirectedEdge(this, up_right, current_weights[col - 1]))

            # Left
            if col > 1:
                left = row * w + col - 1
                block.add_edge(DirectedEdge(left, this, prev_weights[col - 2]))
                block.add_edge(DirectedEdge(this, left, current_weights[col - 1]))

            # Right
            if col < w:
                right = row * w + col + 1
                block.add_edge(DirectedEdge(right, this, prev_weights[col]))
                block.add_edge(DirectedEdge(this, right, current_weights[col - 1]))

        prev_weights = current_weights

    # Connect source and target to all in first and last row
    for i in range(1, w + 1):
        block.add_edge(DirectedEdge(0, i, 0))
        block.add_edge(DirectedEdge((h - 1) * w + i, h * w + 1, prev_weights[i - 1]))

    # print(block)
    # Find shortest path
    bf = BellmanFordSP(block, 0)
    path = bf.path_to(h * w + 1)
    if path is None:
        raise ValueError("No path found")
    # print(path)

    # Print original weights, without the ones part of the path
    for row in range(h):
        for col in range(w):
            this = row * w + col + 1
            if any(this == edge.from_vertex() for edge in path):
                print(" ", end="")
            else:
                print(all_weights[row][col], end="")
        print()
