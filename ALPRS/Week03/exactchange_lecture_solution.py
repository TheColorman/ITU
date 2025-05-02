t = int(input())


def solve_dp(max_price: int, coins: list[int]):
    # Create table where each row represents the current coin, and each column
    # the price. Values are the number of coins required to reach the price.
    dp = [[float("inf") for _ in range(max_price + 1)] for _ in range(len(coins) + 1)]
    for i in range(len(coins) + 1):
        # No matter how what coin, 0 are needed to reach price of 0
        dp[i][0] = 0
    for j in range(1, max_price + 1):
        # No matter the price, infinite coins are needed if there are 0 available
        dp[0][j] = float("inf")
    # For every coin...
    for i in range(1, len(coins) + 1):
        coin = coins[i - 1]
        # For every price...
        for j in range(1, max_price + 1):
            # Set the number of coins needed when i available coins and j price required to..
            dp[i][j] = min(
                # i - 1 coins required, if that was enough, use that
                dp[i - 1][j],
                # previous number of coins required, current price minus value
                # of current coin, gives us the number of coins required to
                # reach the previous price. Then, adding our own coin, will
                # give us the number of coins required for this price.
                dp[i - 1][j - coin] + 1 if j - coin >= 0 else float("inf"),
            )
    return dp


for _ in range(t):
    price = int(input())
    n = int(input())
    coins = [int(input()) for _ in range(n)]

    max_price = price + max(coins)

    dp = solve_dp(max_price, coins)

    for best_price in range(price, max_price + 1):
        if dp[-1][best_price] != float("inf"):
            print(best_price, dp[-1][best_price])
            break

    # print(coins)
