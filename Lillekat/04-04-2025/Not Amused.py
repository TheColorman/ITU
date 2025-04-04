from collections import defaultdict


def report_day(day: int, data: dict[str, int]):
    print(f"Day {day}")
    for name in sorted(data.keys()):
        print(f"{name} ${data[name] * 0.1:.2f}")
    print()


def parse_day(day: int):
    assert input() == "OPEN"

    customers: dict[str, int] = {}
    data: dict[str, int] = defaultdict(lambda: 0)

    while True:
        line = input().split()
        command = line[0]
        match command:
            case "CLOSE":
                report_day(day, data)
                return
            case "ENTER":
                name = line[1]
                time = int(line[2])
                if name in customers:
                    raise ValueError("Customer already entered")
                customers[name] = time

            case "EXIT":
                name = line[1]
                time = int(line[2])
                if name not in customers:
                    raise ValueError("Customer not entered")
                data[name] += time - customers[name]
                del customers[name]

            case _:
                raise ValueError("Invalid input")


day = 0
while True:
    day += 1
    try:
        parse_day(day)
    except EOFError:
        exit()
