import Data.Char
-- Mid-chapter exercise: enumFromTo

eftBool :: Bool -> Bool -> [Bool]
eftBool a b
  | a == b = [b]
  | b < a = []
  | otherwise = [a, b]

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd a b
  | a == b = [b]
  | b < a = []
  | otherwise = a : (eftOrd (succ a) b)

eftInt :: Int -> Int -> [Int]
eftInt a b
  | a == b = [b]
  | b < a = []
  | otherwise = a : (eftInt (succ a) b)

eftChar :: Char -> Char -> [Char]
eftChar a b
  | a == b = [b]
  | b < a = []
  | otherwise = a : (eftChar (succ a) b)

-- Mid-chapter exercise: Thy Fearful Symmetry

-- *Main> myWords "all i wanna do is have some fun"
-- ["all","i","wanna","do","is","have","some","fun"]
myWords :: [Char] -> [[Char]]
myWords s
  | s == "" = []
  | takeWhile (/= ' ') s == "" = myWords (dropWhile (== ' ') s)
  | otherwise = (takeWhile (/= ' ') s) : myWords (dropWhile (/= ' ') s)

-- Next, write a function that takes a string and returns a list of
-- strings, using newline separators to break up the string

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful symmetry?"
sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

myLines :: String -> [String]
myLines s
  | s == "" = []
  | takeWhile (/= '\n') s == "" = myLines (dropWhile (== '\n') s)
  | otherwise = (takeWhile (/= '\n') s) : myLines (dropWhile (/= '\n') s)

-- Try writing a new function that parameterizes the character
-- you’re breaking the string argument on and rewrite myWords and
-- myLines using it

myChars :: String -> Char -> [String]
myChars s c
  | s == "" = []
  | takeWhile (/= c) s == "" = myChars (dropWhile (== c) s) c
  | otherwise = (takeWhile (/= c) s) : myChars (dropWhile (/= c) s) c

mySqr = [x^2 | x <- [1..5]]
myCube = [y^3 | y <- [1..5]]

-- First write an expression that will make tuples of the outputs of mySqr and myCube.
makeTuple = [(x, y) | x <- mySqr, y <- myCube]

-- Now alter that expression so that it only uses the x and y values that are less than 50.
makeTupleUnder50 = [(x, y) | x <- mySqr, y <- myCube, x < 50, y < 50]

-- Apply another function to that list comprehension to determine how many tuples inhabit your output list.
countTuples = length makeTupleUnder50

-- Exercises: Zipping
-- 1. Write your own version of `zip :: [a] -> [b] -> [(a, b)]` and ensure it behaves the same as the original.

-- Question: is there a way to do this with only one zip fn declaration?
zip' :: [a] -> [b] -> [(a, b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = [(x, y)] ++ zip' xs ys

-- 2.  Do what you did for zip, but now for `zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]`
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = [f x y] ++ zipWith f xs ys

-- 3.  Rewrite your zip in terms of the zipWith you wrote.
zip'' :: [a] -> [b] -> [(a, b)]
zip'' = zipWith' (\x y -> (x, y))

-- Chapter Exercises

-- Data.Char

removeLowers :: [Char] -> [Char]
removeLowers = filter isUpper

capitalizeFirst :: [Char] -> [Char]
capitalizeFirst (x:xs) = [toUpper x] ++ xs

capitalizeAll :: [Char] -> [Char]
capitalizeAll "" = []
capitalizeAll (x:xs) = [toUpper x] ++ capitalizeAll xs

returnCapitalHead :: [Char] -> Char
returnCapitalHead (x:xs) = toUpper x

returnCapitalHead' :: [Char] -> Char
returnCapitalHead' = head . capitalizeFirst

-- Writing your own standard functions
myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = x || myOr xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny _ [] = False
myAny f (x:xs) = f x || myAny f xs

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem e (x:xs) = e == x || myElem e xs

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

squish :: [[a]] -> [a]
squish [] = []
squish (x:xs) = x ++ squish xs

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap _ [] = []
squishMap f (x:xs) = f x ++ squishMap f xs

-- Why do I get this error: Equations for ‘squishAgain’ have different numbers of arguments- when I remove the arg?
squishAgain :: [[a]] -> [a]
squishAgain [] = []
squishAgain l = squishMap (\x -> x) l

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ [] = error "Empty list"
myMaximumBy _ (x : []) = x
myMaximumBy f (x : y : ys) = myMaximumBy f (z : ys)
  where z = if f x y == GT then x else y

myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ [] = error "Empty list"
myMinimumBy _ (x : []) = x
myMinimumBy f (x : y : ys) = myMinimumBy f (z : ys)
  where z = if f x y == LT then x else y

myMaximum :: (Ord a) => [a] -> a
myMaximum = myMaximumBy compare

myMinimum :: (Ord a) => [a] -> a
myMinimum = myMinimumBy compare
