from collections import defaultdict
import sys
from typing import Literal

sys.setrecursionlimit(10**6)

# all graphs are (default) dictionaries
# vertex -> (vertex -> capacity), by default capacity is 0

Graph = defaultdict[int, defaultdict[int, int]]


def bfs(
    graph: Graph, src: int, dest: int, mincap: int = 0
) -> (
    tuple[Literal[True], list[tuple[int, int]]] | tuple[Literal[False], set[int]]
):  # returns path to dest or reachable set
    parent = {src: src}
    layer = [src]
    while layer:
        nextlayer: list[int] = []
        for u in layer:
            for v, cap in graph[u].items():
                if cap > mincap and v not in parent:
                    parent[v] = u
                    nextlayer.append(v)
                    if v == dest:
                        p: list[tuple[int, int]] = []
                        current_vertex = dest
                        while src != current_vertex:
                            p.append((parent[current_vertex], current_vertex))
                            current_vertex = parent[current_vertex]
                        return (True, p)
        layer = nextlayer
    return (False, set(parent))


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
            # print(f'explore {u} {v}, {cap}')
            match dfs(graph, v, dest, mincap, seen):
                case (True, p):
                    p.append((u, v))
                    return (True, p)
                case (False, _):
                    pass
    return (False, seen)


def flow(
    orggraph: Graph, src: int, dest: int
) -> tuple[int, dict[int, dict[int, int]], set[int]]:
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
                print("path:", *reversed(p))
                saturation = min(graph[u][v] for u, v in p)
                print(
                    current_flow, saturation
                )  # ,[f"{u[0]}-{u[1]}:{orggraph[u[0]][u[1]]}:{graph[u][v]}" for u,v in p if u[2]==0])
                current_flow += saturation
                for u, v in p:
                    graph[u][v] -= saturation
                    graph[v][u] += saturation


if __name__ == "__main__":
    n, m = map(int, input().split())
    s, t = map(int, input().split())
    graph: Graph = defaultdict(lambda: defaultdict(int))
    for _ in range(m):
        u, v, c = map(int, input().split())
        graph[u][v] = c

    flow_value, residual_graph, _ = flow(graph, s, t)
    print(flow_value)
