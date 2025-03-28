def isLeft(vec1: complex, vec2: complex) -> bool:
    return vec1.real * vec2.imag - vec1.imag * vec2.real > 0


def isRight(vec1: complex, vec2: complex) -> bool:
    return vec1.real * vec2.imag - vec1.imag * vec2.real < 0


def convex_hull(points: list[complex]) -> list[complex]:
    # O(n log n) time for sorting
    points.sort(
        key=lambda x: (x.real, x.imag)
    )  # cannot sort complex numbers, explicitly declare x first.

    upper = points[:2]
    lower = points[:2]

    for p in points[2:]:
        while len(upper) >= 2 and isLeft(upper[-1] - upper[-2], p - upper[-1]):
            _ = upper.pop()
        upper.append(p)
        while len(lower) >= 2 and isRight(lower[-1] - lower[-2], p - lower[-1]):
            _ = lower.pop()
        lower.append(p)

    hull = upper[:-1] + lower[::-1]
    return hull


def area(polygon: list[complex]):
    return 0.5 * abs(
        sum(
            polygon[i].real * polygon[i + 1].imag
            - polygon[i].imag * polygon[i + 1].real
            for i in range(len(polygon) - 1)
        )
    )


while True:
    n = int(input())
    if n == 0:
        exit()

    points = [complex(*map(float, input().split())) for _ in range(n)]
    print(area(convex_hull(points)))
