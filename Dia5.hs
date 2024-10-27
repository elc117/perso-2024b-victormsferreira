import Text.Parsec (parse)
splitString :: Char -> String -> [String]
splitString c s = case dropWhile (== c) s of
                       "" -> []
                       x -> w : splitString c y
                            where (w, y) = break (== c) x

parseSeeds :: String -> [Int]
parseSeeds seeds = map read $ drop 1 $ splitString ' ' seeds

parseSeedsRange :: [Int] -> [(Int, Int)]
parseSeedsRange [] = []
parseSeedsRange (a:b:rest) = (a, a+b) : parseSeedsRange rest


parseRange :: String -> (Int, Int, Int)
parseRange range = (\[ss, ds, l] -> (ss, ds, l) ) $ map read $ splitString ' 'range

parseMap ::  [String] -> [(Int, Int, Int)] -> [[(Int, Int, Int)]]
parseMap [] m = [m]
parseMap (l:r) currentMappings | l == "" = currentMappings : parseMap r []
                               | head l `elem` ['a'..'z'] = currentMappings : parseMap r []
                               | otherwise = parseMap r (parseRange l : currentMappings) 

valueInRange :: Int -> (Int, Int, Int) -> Bool
valueInRange value (_,start,len) = value >= start && value < start+len

mapping :: Int -> [(Int, Int, Int)]  -> Int
mapping key maps | null inRangeOf = key
                 | otherwise = dst + (key - srt)
                    where inRangeOf = filter (valueInRange key) maps
                          ((dst, srt, _):_) = inRangeOf

seedToLocation :: [(Int, Int, Int)] -> [(Int, Int, Int)] -> [(Int, Int, Int)] -> [(Int, Int, Int)]  -> [(Int, Int, Int)] -> [(Int, Int, Int)] -> [(Int, Int, Int)] -> Int -> Int
seedToLocation sts stf ftw wtl ltt tth htl seed = mapping (mapping (mapping (mapping (mapping (mapping (mapping seed sts) stf) ftw) wtl) ltt) tth) htl

part1 :: [String] -> Int
part1 lines = minimum $ map (seedToLocation sts stf ftw wtl ltt tth htl) seeds
                where (seedsLine : mapsLines) = lines
                      seeds = parseSeeds seedsLine
                      [sts, stf, ftw, wtl, ltt, tth, htl] = filter (not . null) $ parseMap mapsLines []

-- Solução mais óbvia para parte 2, demoraria muito tempo para executar
part2' :: [String] -> Int
part2' lines = minimum $ map (seedToLocation sts stf ftw wtl ltt tth htl) allSeeds
                where (seedsLine : mapsLines) = lines
                      seeds = parseSeeds seedsLine
                      seedRanges = parseSeedsRange seeds
                      allSeeds = concatMap (\(x, y) -> [x..x+y]) seedRanges
                      [sts, stf, ftw, wtl, ltt, tth, htl] = filter (not . null) $ parseMap mapsLines []

-- Solução Melhorada

--rangeIntersect :: (Int, Int) -> (Int, Int) -> (Int, Int)
--rangeIntersect (a,b) (x,y) | start > end = (0,0)
--                           | otherwise = (start, end)
--                               where start = max a x
--                                     end = min b y
--rangeSplit :: (Int, Int) -> Int -> Int -> [(Int, Int)]
--rangeSplit range min max = filter (/= (0,0)) [a, b, c]
--                             where a = rangeIntersect range (0, min - 1)
--                                   b = rangeIntersect range (min, max)
--                                   c = rangeIntersect range (max + 1, snd range)
--
--mappingRanges :: [(Int, Int)] -> [(Int, Int, Int)] -> [(Int, Int)]
--mappingRanges (src:srcr) m = 
--
--part2 :: [String] -> Int
--part2 lines = minimum $ map fst $ concatMap (seedToLocationR sts stf ftw wtl ltt tth htl) seedRanges
--                where (seedsLine : mapsLines) = lines
--                      seeds = parseSeeds seedsLine
--                      seedRanges = parseSeedsRange seeds
--                      [sts, stf, ftw, wtl, ltt, tth, htl] = filter (not . null) $ parseMap mapsLines []

main = do
    input <- readFile "input5.txt"
    print $ part1 $ lines input
    print $ part2' $ lines input