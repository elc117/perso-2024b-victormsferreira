digitfy :: String -> Char
digitfy ('o':'n':'e':x) = '1'
digitfy ('t':'w':'o':x) = '2'
digitfy ('t':'h':'r':'e':'e':x) = '3'
digitfy ('f':'o':'u':'r':x) = '4'
digitfy ('f':'i':'v':'e':x) = '5'
digitfy ('s':'i':'x':x) = '6'
digitfy ('s':'e':'v':'e':'n':x) = '7'
digitfy ('e':'i':'g':'h':'t':x) = '8'
digitfy ('n':'i':'n':'e':x) = '9'
digitfy (c:x) = c


digits :: String -> String
digits = filter (\c -> elem c ['0'..'9'])

digits' :: String -> String
digits' [] = []
digits' x = (digitfy x) : (digits' (tail x))

firstC :: String -> Char
firstC (x:_) = x

lastC :: String -> Char
lastC [x] = x
lastC (_:x) = lastC x

calibrationValue :: String -> Int
calibrationValue x = read [firstC d, lastC d] :: Int
                     where d = digits x

part1 :: [String] -> Int
part1 lines = sum [calibrationValue x | x <- lines]

part2 :: [String] -> Int
part2 lines = sum [calibrationValue (digits' x) | x <- lines]

main = do
    input <- readFile "input1"
    print $ part1 (lines input)
    print $ part2 (lines input)
