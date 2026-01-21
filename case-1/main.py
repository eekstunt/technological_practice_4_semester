def sum_negative_between_min_max(values):
    if not values:
        return 0
    min_value = values[0]
    max_value = values[0]
    min_index = 0
    max_index = 0
    for index, value in enumerate(values):
        if value < min_value:
            min_value = value
            min_index = index
        if value > max_value:
            max_value = value
            max_index = index
    start = min(min_index, max_index) + 1
    end = max(min_index, max_index)
    if start >= end:
        return 0
    total = 0
    for value in values[start:end]:
        if value < 0:
            total += value
    return total


def main():
    first_line = input().strip()
    if not first_line:
        return
    values = [int(value) for value in first_line.split()]
    result = sum_negative_between_min_max(values)
    print(result)


if __name__ == "__main__":
    main()
