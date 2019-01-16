module WordNumber where

import Data.List (intersperse)

digitToWord :: Int -> String
digitToWord n
  | n == 0 = "zero"
  | n == 1 = "one"
  | n == 2 = "two"
  | n == 3 = "three"
  | n == 4 = "four"
  | n == 5 = "five"
  | n == 6 = "six"
  | n == 7 = "seven"
  | n == 8 = "eight"
  | n == 9 = "nine"
  | otherwise = error $ "n is not a single digit: " ++ show n

-- e.g. 12345 -> [1,2,3,4,5]
digits :: Int -> [Int]
digits n = go n []
  where go num arr
          | num `div` 10 == 0 = [num] ++ arr
          | otherwise = go newNum ([digit] ++ arr)
              where newNum = num `div` 10
                    digit = num `mod` 10

wordNumber :: Int -> String
wordNumber = concat . intersperse "-" . map digitToWord . digits
