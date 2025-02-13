n = int(input())
_trips = [input().split() for i in range(n)]
trips = {}
for trip in _trips:
    country = trip[0]
    year = int(trip[1])

    if country not in trips:
        trips[country] = []

    trips[country].append(year)

for country in trips.keys():
    trips[country] = sorted(trips[country])

q = int(input())

for _ in range(q):
    query = input().split()
    country = query[0]
    trip = int(query[1])

    print(trips[country][trip-1])
