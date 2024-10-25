splitString :: Char -> String -> [String]
splitString c s = case dropWhile (== c) s of
                       "" -> []
                       x -> w : splitString c y
                            where (w, y) = break (== c) x

parseCube :: [String] -> (Int, Int, Int)
parseCube [n, 'r':_] = (read n :: Int, 0, 0)
parseCube [n, 'g':_] = (0, read n :: Int, 0)
parseCube [n, 'b':_] = (0, 0, read n :: Int)
parseCube [n, s] = (-100, -100, -100)

parseSet :: String -> (Int, Int, Int)
parseSet set = foldl (\(x,y,z) (a,b,c) -> (x+a, y+b, z+c)) (0,0,0) $ map parseCube cubes where cubes = map (splitString ' ') $ splitString ',' set

parseSets :: String -> [(Int, Int, Int)]
parseSets sets = map parseSet (splitString ';' sets)

parseGame :: String -> (Int, [(Int, Int, Int)])
parseGame line = (read (drop 5 gameIndex) :: Int, parseSets sets) 
                    where [gameIndex, sets] = splitString ':' line


setImpossible :: (Int, Int, Int) -> (Int, Int, Int) -> Bool
setImpossible (bagR, bagG, bagB) (setR, setG, setB) = (bagR < setR) || (bagG < setG) || (bagB < setB)

gameIsPossible :: (Int, Int, Int) -> (Int, [(Int, Int, Int)]) -> Bool
gameIsPossible bag game = length (filter (setImpossible bag) (snd game)) == 0

part1 :: [String] -> Int
part1 lines = sum [x | (x, _) <- possibleGames] 
                  where possibleGames = filter (gameIsPossible (12, 13, 14)) games
                        games = map parseGame lines

maxCubes :: (Int, Int, Int) -> (Int, Int, Int) -> (Int, Int, Int)
maxCubes (x,y,z) (a,b,c) = (max x a, max y b, max z c)

minimumPossible :: [(Int, Int, Int)] -> (Int, Int, Int)
minimumPossible = foldl maxCubes (0,0,0)

powerOfSet :: [(Int, Int, Int)] -> Int
powerOfSet set = x * y * z where (x, y, z) = minimumPossible set

part2 :: [String] -> Int
part2 lines = sum [powerOfSet x | (_, x) <- games] 
                  where games = map parseGame lines

main = do
    input <- readFile "input2.txt"
    print $ part1 (lines input)
    print $ part2 (lines input)
