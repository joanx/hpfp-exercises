import Data.List (sort)

-- Doesn't pass, needs to be instance of Num a
-- i :: a
-- i = 1

-- Doesn't pass, needs to be an instance of Fractional a ???
-- f :: Num a => a
-- f = 1.0

-- Passes
f2 :: Fractional a => a
f2 = 1.0

-- Passes, RealFrac implements Fractional
f3 :: RealFrac a => a
f3 = 1.0

-- Passes, identity fn can return anything
freud :: Ord a => a -> a
freud x = x

-- Passes, identity fn
freud2 :: Int -> Int
freud2 x = x

myX = 1 :: Int

-- Doesn't pass, input is not a guaranteed Int type
sigmund :: a -> a
sigmund x = myX

-- Doesn't pass, input is not a guaranteed Int type
sigmund' :: Num a => a -> a
sigmund' x = myX

-- Passes
jung :: [Int] -> Int
jung xs = head (sort xs)

-- Passes
young :: Ord a => [a] -> a
young xs = head (sort xs)

-- Passes
mySort :: [Char] -> [Char]
mySort = sort

-- Doesn't pass, mySort requires string
signifier :: Ord a => [a] -> a
signifier xs = head (mySort xs)
