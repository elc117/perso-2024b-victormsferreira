isSymbol :: Char -> Bool
isSymbol c = notElem c "0123456789."

charAt :: Int -> Int -> [String] -> Char
charAt y x schematic | x >= length (head schematic) = '.'
                     | x < 0 = '.'
                     | y >= length schematic = '.'
                     | y < 0 = '.'
                     | otherwise = schematic !! y !! x


regionAdjacentToSymbol :: Int -> Int -> Int -> [String] -> Bool
regionAdjacentToSymbol len y x schematic = 
    any isSymbol (map (\(x', y') -> charAt y' x' schematic) allNeighbors)
        where allXs = [x + a | a <- take (len+2) [-1, 0..]]
              allYs = [y + a | a <- [-1, 0, 1]]
              allNeighbors = [(x, y) | x <- allXs, y <- allYs]

isDigit :: Char -> Bool
isDigit c = elem c "0123456789"

getNumber :: Int -> Int -> String -> ((Int, Int, Int, Int), String)
getNumber _ _ "" = ((0,0,0,0), "")
getNumber row col (c:r) | isDigit c = ((row, col, len, num), leftover)
                        | otherwise  = getNumber row (col + 1) r
                            where numString = takeWhile isDigit (c:r)
                                  len = length numString
                                  num = read numString :: Int
                                  leftover = dropWhile isDigit r

getNumbersFromLine :: Int -> Int -> String -> [(Int, Int, Int, Int)]
getNumbersFromLine row col s | (\(_,_,l,_) -> l) num == 0 = []
                             | otherwise = num : getNumbersFromLine row newCol leftover
                             where numberGot = getNumber row col s
                                   num = fst numberGot
                                   leftover = snd numberGot
                                   newCol = (\(_, c, l, _) -> c+l) num

getNumbersFromSchematic :: [String] -> [(Int, Int, Int, Int)]     
getNumbersFromSchematic schem = concat [getNumbersFromLine x 0 l | (x, l) <- zip [0,1..] schem]  

part1 :: [String] -> Int
part1 schem = sum (map (\(_,_,_,n) -> n) partNumbers)
                  where numbers = getNumbersFromSchematic schem
                        partNumbers = filter (\(r,c,l,_) -> regionAdjacentToSymbol l r c schem) numbers


getPotentialGearsFromLine :: Int -> Int -> String -> [(Int, Int)]
getPotentialGearsFromLine _ _ "" = []
getPotentialGearsFromLine row col ('*':r) = (row, col) : getPotentialGearsFromLine row (col+1) r
getPotentialGearsFromLine row col (_:r) = getPotentialGearsFromLine row (col+1) r

getPotentialGearsFromSchematic :: [String] -> [(Int, Int)]
getPotentialGearsFromSchematic schem = concat [getPotentialGearsFromLine x 0 l | (x, l) <- zip [0,1..] schem]  

pointAdjacentToRegion :: (Int, Int, Int) -> (Int, Int) -> Bool
pointAdjacentToRegion (ry, rx, len) (y, x) = (x >= x0) && (x <= x1) && (y >= y0) && (y <= y1)
                                                  where x0 = rx - 1
                                                        x1 = rx + len
                                                        y0 = ry - 1
                                                        y1 = ry + 1

numbersAdjacentToPoint :: [(Int, Int, Int, Int)] -> (Int, Int) -> [(Int, Int, Int, Int)]
numbersAdjacentToPoint numbers point = filter (\(r, c, l, _) -> pointAdjacentToRegion (r, c, l) point) numbers

gearRatio :: [(Int, Int, Int, Int)] -> (Int, Int) -> Int
gearRatio nums g | length adjacents /= 2 = 0
                 | otherwise = product $ map (\(_,_,_,n) -> n) adjacents
                     where adjacents = numbersAdjacentToPoint nums g

part2 :: [String] -> Int
part2 schem = sum $ map (gearRatio nums) gears
                  where nums = getNumbersFromSchematic schem
                        gears = getPotentialGearsFromSchematic schem

main :: IO ()
main = do
    input <- readFile "input3.txt"
    print $ part1 (lines input)
    print $ part2 (lines input)
