from typing import Any


n = int(input())
menu = list(map(int, input().split()))
assert len(list(menu)) == n

m = int(input())
orders = list(map(int, input().split()))
assert len(list(orders)) == m

max_cost = max(orders)
dp: list[Any] = [None] * (max_cost + 1)
dp[0] = tuple()  # No items for 0 cost

for item, cost in enumerate(menu, 1):
    # print(f"{item=}, {cost=}")
    # Calculate combination for every bill more expensive that this item
    for price in range(cost, max_cost + 1):
        # print(f"  {price=}")
        # print(f"  {dp=}")
        if dp[price - cost] is None:
            # print("  No calculation for this bill")
            # No calculation for the rest of the bill excluding this item
            # yet
            continue
        if dp[price - cost] == "amb":
            # print("  Previous bill is ambiguous")
            # Bill excluding this item has already been deemed ambiguous,
            # so including this item is still ambiguous
            dp[price] = "amb"
        elif dp[price] is None:
            # This bill has not been calculated yet, but bill excluding
            # this item has, so we know this bill can be calculated just
            # by adding this item to the previous bill.
            dp[price] = (dp[price - cost], item)
            # print(f"  Adding {item} to {price - cost} = {dp[price]}")
        else:
            # print("  Current bill already exists, so it has become ambiguous")
            # This bill (dp[price]) has already been calculated before.
            # Since this is a know path to the same price, it's ambiguous.
            dp[price] = "amb"

# print(dp)
for bill in orders:
    val = dp[bill]
    # print(f"{bill=}: {val}")
    if val is None:
        print("Impossible")
    elif val == "amb":
        print("Ambiguous")
    else:
        vals = []
        while len(val):
            vals.append(val[1])
            val = val[0]
        print(*vals[::-1])
