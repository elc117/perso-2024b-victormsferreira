splitString :: Char -> String -> [String]
splitString c s = case dropWhile (== c) s of
                       "" -> []
                       x -> w : splitString c y
                            where (w, y) = break (== c) x

parseCard :: String -> (Int, [Int], [Int])
parseCard line = (read (drop 5 card), map read $ splitString ' ' winningNumbers, map read $ splitString ' ' haveNumbers)
                   where [card,numbers] = splitString ':' line
                         [winningNumbers, haveNumbers] = splitString '|' numbers

matches :: [Int] -> [Int] -> [Int]
matches winning have = filter (`elem` winning) have

cardScore :: (Int, [Int], [Int]) -> Int
cardScore (_, w, h) | numMatches == 0 = 0
                    | otherwise = 2 ^ (numMatches - 1)
                    where numMatches = length $ matches w h

part1 :: [String] -> Int
part1 lines = sum $ map (cardScore . parseCard) lines


-- Solução mais óbvia, demoraria muito tempo para rodar
cardReceiveCards :: (Int, [Int], [Int]) -> [Int]
cardReceiveCards (num, w, h) = [num + x | x <- take n [1..]]
                                 where n = length $ matches w h

getCards :: [(Int, [Int], [Int])] -> [Int] -> [Int]
getCards cards [] = []
getCards cards (i:r) = i : getCards cards (r ++ cardReceiveCards (cards !! (i - 1)))

part2' :: [String] -> Int
part2' lines = length $ getCards cards indices 
                 where cards = map parseCard lines
                       indices = map (\(i,_,_) -> i) cards

-- Solução melhorada

-- getTotalCards :: [(Int, [Int], [Int])] -> [Int] -> [Int]
-- getTotalCards [] copies = copies
-- getTotalCards (c:cardsr) copies = getTotalCards cardsr newCopies
--                             where newCopies = (take index copies) ++ [cardCopies + (copies !! (index + x)) | x <- take nmatches [0, 1..]] ++ (drop (index + nmatches) copies)
--                                   (index, winning, has) = c
--                                   nmatches = length $ matches winning has
--                                   cardCopies = copies !! (index-1)

getTotalCards :: [(Int, [Int], [Int])] -> [Int] -> [Int]
getTotalCards [] _ = []
getTotalCards (c:cardsr) (y:copiesr) = y : getTotalCards cardsr newCopies
                            where newCopies = [y + x | x <- take nmatches copiesr] ++ drop nmatches copiesr
                                  (index, winning, has) = c
                                  nmatches = length $ matches winning has


part2 :: [String] -> Int
part2 lines = (sum (getTotalCards cards copies)) 
                where cards = map parseCard lines
                      copies = take (length cards) [1, 1..]

main = do
    input <- readFile "input4.txt"
    print $ part1 (lines input)
    print $ part2 (lines input)

