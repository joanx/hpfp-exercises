addExclamation :: String -> String
addExclamation x = (++) x "!"

fifthLetter :: String -> Char
fifthLetter x = (!!) x 4

drop9 :: String -> String
drop9 x = drop 9 x

thirdLetter :: String -> Char
thirdLetter x = (!!) x 2

letterIndex :: Int -> Char
letterIndex x = (!!) "any string goes here" x

rvs :: String -> String
rvs x = concat [(drop 9 x), " ", (take 2 (drop 6 x)), " ", (take 5 x)]
