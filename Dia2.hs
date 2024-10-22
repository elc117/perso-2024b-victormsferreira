parseSet 

parseSets :: String -> [(Int, Int, Int)]
parseSets sets = 

parseGame :: String -> (Int, [(Int, Int, Int)])
parseGame line = ((read gameIndex :: Int), parseSets sets) 
                    where gameIndex = (takeWhile (/= ':') (drop 5 line))
                          sets = dropWhile (/= ':') lines
