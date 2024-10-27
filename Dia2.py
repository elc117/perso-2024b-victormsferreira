def parseCube(s):
    split = s.split(' ')
    num = int(split[0])
    color = split[1]
    if color[0] == 'r':
        return (num, 0, 0)
    if color[0] == 'g':
        return (0, num, 0)
    if color[0] == 'b':
        return (0, 0, num)

def parseSet(s):
    cubes = s.split(', ')
    r = 0
    g = 0
    b = 0
    for cube in cubes:
        (x, y, z) = parseCube(cube)
        r += x
        g += y
        b += z
    return (r, g, b)

def parseSets(s):
    sets = s.split('; ')
    s = []
    for set in sets:
        s.append(parseSet(set))
    return s

def parseGame(s):
    split = s.split(':')
    gameIndex = int(split[0][5:])
    sets = parseSets(split[1][1:])
    return (gameIndex, sets)

def part1(lines):
    games = []
    sum = 0
    for line in lines:
        games.append(parseGame(line))
    for (index, sets) in games:
        isPossible = True
        for (r, g, b) in sets:
            if r > 12 or g > 13 or b > 14:
                isPossible = False
                break
        if isPossible:
            sum += index
    return sum
    
def part2(lines):
    games = []
    sum = 0
    for line in lines:
        games.append(parseGame(line))
    for (index, sets) in games:
        maxR = 0
        maxG = 0
        maxB = 0
        for (r, g, b) in sets:
            if r > maxR:
                maxR = r
            if g > maxG:
                maxG = g
            if b > maxB:
                maxB = b
        sum += maxR * maxG * maxB
    return sum


def main():
    input = open("input2.txt", "r")
    lines = input.readlines()
    input.close()
    print(part1(lines))
    print(part2(lines))

main()