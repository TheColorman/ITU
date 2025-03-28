from collections import defaultdict

def dfs(graph, u, dest, mincap, seen):  # returns path to dest
    if u in seen:
        return (False, seen)
    seen.add(u)
    for v, cap in graph[u].items():
        if cap > mincap:  # only consider edges with capacity > mincap
            if v == dest:
                return (True, [(u, v)])
            ret = dfs(graph, v, dest, mincap, seen)
            if ret[0] == True:
                p = ret[1]
                p.append((u, v))
                return (True, p)
    return (False, seen)


def flow(orggraph, src, dest):
    graph = defaultdict(lambda: defaultdict(int))
    maxcapacity = 0
    for u, d in orggraph.items():
        for v, c in d.items():
            graph[u][v] = c
            maxcapacity = max(maxcapacity, c)

    current_flow = 0
    mincap = maxcapacity  # set to 0 to disable capacity scaling
    while True:
        # ispath, p_or_seen = bfs(graph,src,dest,mincap)
        suc, p_or_seen = dfs(graph, src, dest, mincap, set())
        if not suc:
            seen = p_or_seen
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
        else:
            p = p_or_seen
            saturation = min(graph[u][v] for u, v in p)
            current_flow += saturation
            for u, v in p:
                graph[u][v] -= saturation
                graph[v][u] += saturation


N, M = map(int, input().split())

G = defaultdict(lambda: defaultdict(int))

# source and sink
src = "source"
snk = "sink"

for i in range(M):
    A, B = input().split()
    G[src][f"{A}-src"] = 1
    G[src][f"{B}-src"] = 1
    G[f"{A}-snk"][snk] = 1
    G[f"{B}-snk"][snk] = 1

    G[f"{A}-src"][f"{B}-snk"] = 1
    G[f"{B}-src"][f"{A}-snk"] = 1

flow_value, residual_graph, seen = flow(G, src, snk)

hits = []

for i in range(1, N + 1):
    if f"{i}-src" not in residual_graph:
        print("Impossible")
        exit()
    targets = residual_graph[f"{i}-src"]
    if not targets:
        print("Impossible")
        exit()

    hits.append(targets.popitem()[0].split("-")[0])

print("\n".join(hits))
