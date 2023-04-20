from itu.algs4.searching.red_black_bst import RedBlackBST


class Timestamp:
    seconds = 0
    timestamp = ""

    def __init__(self, i) -> None:
        if type(i) == int:
            self.fromsec(i)
        elif type(i) == str:
            self.fromtimestamp(i)
        else:
            raise ValueError("Only supports int or str type, got ", type(i))

    def tosec(self) -> int:
        HH, MM, SS = [int(i) for i in self.timestamp.split(":")]
        seconds = SS + MM*60 + HH*60*60
        return seconds

    def totimestamp(self) -> str:
        HH = self.seconds // (60*60)
        MM = (self.seconds - HH*60*60) // 60
        SS = self.seconds - HH*60*60 - MM*60
        HH, MM, SS = str(HH), str(MM), str(SS)
        return HH.zfill(2) + ":" + MM.zfill(2) + ":" + SS.zfill(2)
    
    def fromsec(self, s: int) -> object:
        self.seconds = s
        self.timestamp = self.totimestamp()
    
    def fromtimestamp(self, t: str) -> object:
        self.timestamp = t
        self.seconds = self.tosec()

    def __eq__(self, __value: object) -> bool:
        return self.tosec() == __value.tosec()

    def __ne__(self, __value: object) -> bool:
        return self.tosec() != __value.tosec()

    def __lt__(self, __value: object) -> bool:
        return self.tosec() < __value.tosec()

    def __gt__(self, __value: object) -> bool:
        return self.tosec() > __value.tosec()

    def __repr__(self) -> str:
        return self.totimestamp() + f" ({self.tosec()})"


n, m = [int(i) for i in input().split(" ")]
_flights = [(Timestamp(dep_time), dest) for i in range(n)
            for dep_time, dest in [input().split(" ")]]
operations = [(operation, parameters.split(" ")) for i in range(m)
              for operation, parameters in [input().split(" ", 1)]]

flights = RedBlackBST()
[flights.put(dep_time, dest) for dep_time, dest in _flights]

def cancel(p):
    s = p[0]

    ts = Timestamp(s)
    flights.delete(ts)
def delay(p):
    s, d = p
    
    ts = Timestamp(s)
    dest = flights.get(ts)
    flights.delete(ts)
    newtime = ts.tosec() + int(d)
    flights.put(Timestamp(newtime), dest)
def reroute(p):
    s, c = p

    ts = Timestamp(s)
    flights.delete(ts)
    flights.put(ts, c)
def destination(p):
    t = p[0]

    ts = Timestamp(t)
    dest = flights.get(ts)
    return dest if dest is not None else "-"
def next(p):
    t = p[0]

    ts = Timestamp(t)
    next_ts = flights.ceiling(ts)
    next_dest = flights.get(next_ts)
    return f"{next_ts.totimestamp()} {next_dest}"
def count(p):
    t1, t2 = p

    ts1, ts2 = Timestamp(t1), Timestamp(t2)
    return flights.size_range(ts1, ts2)

ops = {
    "cancel": cancel,
    "delay": delay,
    "reroute": reroute,
    "destination": destination,
    "next": next,
    "count": count
}

for operation, parameters in operations:
    result = ops[operation](parameters)
    if result is not None:
        print(result)

