from collections import defaultdict
from typing import Literal

Graph = dict[int, dict[int, int]]


def dfs(
    graph: Graph, u: int, dest: int, mincap: int, seen: set[int]
) -> (
    tuple[Literal[True], list[tuple[int, int]]] | tuple[Literal[False], set[int]]
):  # returns path to dest
    if u in seen:
        return (False, seen)
    seen.add(u)
    for v, cap in graph[u].items():
        if cap > mincap:  # only consider edges with capacity > mincap
            if v == dest:
                return (True, [(u, v)])
            match dfs(graph, v, dest, mincap, seen):
                case (True, p):
                    p.append((u, v))
                    return (True, p)
                case (False, _):
                    pass
    return (False, seen)


def flow(orggraph: Graph, src: int, dest: int) -> tuple[int, Graph, set[int]]:
    graph: Graph = defaultdict(lambda: defaultdict(int))
    maxcapacity = 0
    for u, d in orggraph.items():
        for v, c in d.items():
            graph[u][v] = c
            maxcapacity = max(maxcapacity, c)

    current_flow = 0
    mincap = maxcapacity  # set to 0 to disable capacity scaling
    while True:
        # ispath, p_or_seen = bfs(graph,src,dest,mincap)
        match dfs(graph, src, dest, mincap, set()):
            case (False, seen):
                if mincap > 0:
                    mincap = mincap // 2
                    continue
                else:
                    return (
                        current_flow,
                        {
                            a: {
                                b: c - graph[a][b]
                                for b, c in d.items()
                                if graph[a][b] < c
                            }
                            for a, d in orggraph.items()
                        },
                        seen,
                    )
            case (True, p):
                saturation = min(graph[u][v] for u, v in p)
                current_flow += saturation
                for u, v in p:
                    graph[u][v] -= saturation
                    graph[v][u] += saturation


n, m, s, t = map(int, input().split())

G: Graph = defaultdict(lambda: defaultdict(int))

for i in range(m):
    u, v, c = map(int, input().split())
    G[u][v] = c

flow_value, residual_graph, seen = flow(G, s, t)

edges = sum(len(adj) for adj in residual_graph.values())

print(n, flow_value, edges)

for u, adj in residual_graph.items():
    for v, x in adj.items():
        print(u, v, x)
