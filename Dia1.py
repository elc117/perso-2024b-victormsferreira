def digits(x):
    d = []
    for c in x:
        if (c >= '0' and c <= '9'):
            d.append(int(c))
    return d

def digitify(x):
    num_strings = {"one":1,"two":2,"three":3,"four":4,"five":5,"six":6,"seven":7,"eight":8,"nine":9}
    d = []
    for i,c in enumerate(x):
        if (c >= '0' and c <= '9'):
            d.append(int(c))
        else:
            for n in num_strings.keys():
                if x[i:].startswith(n):
                    d.append(num_strings[n])
    return d


def calibration_value(d):
    a = 10 * d[0] + d[-1]
    return a

def part1(lines):
    sum = 0
    for i in lines:
        sum += calibration_value(digits(i))
    return sum

def part2(lines):
    sum = 0
    for i in lines:
        sum += calibration_value(digitify(i))
    return sum

def main():
    input = open("input1.txt", "r")
    lines = input.readlines()
    input.close()
    print(part1(lines))
    print(part2(lines))

main()