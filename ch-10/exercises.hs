-- Database Processing
import Data.Time
data DatabaseItem = DbString String
                  | DbNumber Integer
                  | DbDate UTCTime
                  deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase =
  [ DbDate (UTCTime
    (fromGregorian 1911 5 1)
    (secondsToDiffTime 34123))
  , DbNumber 9001
  , DbString "Hello, world!"
  , DbDate (UTCTime
    (fromGregorian 1921 5 1)
    (secondsToDiffTime 34123))
  ]

addDate :: DatabaseItem -> [UTCTime] -> [UTCTime]
addDate d acc =
  case d of
    DbDate time -> [time] ++ acc
    _ -> acc

addNumber :: DatabaseItem -> [Integer] -> [Integer]
addNumber d acc =
  case d of
    DbNumber int -> [int] ++ acc
    _ -> acc

-- 1. Write a function that filters for DbDate values and returns a list of the UTCTime values inside them.
filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate = foldr addDate []
-- 2. Write a function that filters for DbNumber values and returns a list of the Integer values inside them.
filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber = foldr addNumber []
-- 3. Write a function that gets the most recent date.
mostRecent :: [DatabaseItem] -> UTCTime
mostRecent = maximum . filterDbDate
-- 4. Write a function that sums all of the DbNumber values.
sumDb :: [DatabaseItem] -> Integer
sumDb = sum . filterDbNumber
-- 5. Write a function that gets the average of the DbNumber values.
-- You'll probably need to use fromIntegral to get from Integer to Double.
avgDb :: [DatabaseItem] -> Double
avgDb x = fromIntegral (sumDb x) / fromIntegral (length x)

-- CHAPTER EXERCISES

-- Warm-up and review
stops = "pbtdkg"
vowels = "aeiou"

createTuples :: [Char] -> [Char] -> [(Char, Char, Char)]
createTuples x y = [(a, b, c) | a <- x, b <- y, c <- x]

createTuplesP :: [Char] -> [Char] -> [(Char, Char, Char)]
createTuplesP x y = [(a, b, c) | a <- ['p'], b <- y, c <- x]

nouns = ["Jack", "Jill", "hill"]
verbs = ["go", "run"]

createSentence :: [[Char]] -> [[Char]] -> [([Char], [Char], [Char])]
createSentence x y = [(a, b, c) | a <- x, b <- y, c <- x]

-- What does the following mystery function do? What is its type?
-- Calculate average letters per word

-- Why not (Integral a) => [Char] -> a?
seekritFunc :: [Char] -> Int
seekritFunc x =
  div (sum (map length (words x)))
      (length (words x))

-- Can you rewrite that using fractional division?

seekritFunc2 :: (Fractional a) => [Char] -> a
seekritFunc2 x =
  fromIntegral (sum (map length (words x))) /
      fromIntegral (length (words x))

-- Rewriting funcitons using folds

myOr :: [Bool] -> Bool
myOr = foldr (||) False

myAny :: (a -> Bool) -> [a] -> Bool
myAny f arr = myOr (map f arr)

myElem :: Eq a => a -> [a] -> Bool
myElem a = foldr ((||) . (== a)) False

myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) []

myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr ((:) . f) []

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f = foldr (\x a -> if f x == True then x:a else a) []

squish :: [[a]] -> [a]
squish = foldr (\x a -> x ++ a) []

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f = foldr (\x a -> f x ++ a) []

squishAgain :: [[a]] -> [a]
squishAgain = squishMap id

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy f (x : xs) = foldr (\item res -> if f item res == GT then item else res) x xs

myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy f (x : xs) = foldr (\item res -> if f item res == LT then item else res) x xs
