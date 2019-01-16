-- RECURSION

-- Write a function that recursively sums all numbers from 1 to n, n being the argument.
-- So that if n was 5, you’d add 1 + 2 + 3 + 4 + 5 to get 15. The type should be (Eq a, Num a) => a -> a.
-- Note, this assumes positive numbers only
sumAll :: (Eq a, Num a) => a -> a
sumAll 1 = 1
sumAll n = n + sumAll (n-1)

-- Write a function that multiplies two integral numbers using recursive summation. The type should be (Integral a) => a -> a -> a.
-- Again this assumes positive numbers
multiplyTwo :: (Integral a) => a -> a -> a
multiplyTwo a b
  | a == 0 = 0
  | b == 0 = 0
  | b < 0 = a + multiplyTwo a (b + 1)
  | b > 0 = a + multiplyTwo a (b - 1)

-- Fixing dividedBy to accept divisors that are negative or 0
data DividedResult = Result Integer | DividedByZero

-- Why doesn't this work when (Result x) is not wrapped in parens?
instance Show DividedResult where
  show DividedByZero = "Not applicable"
  show (Result x) = show x

dividedBy :: Integral a => a -> a -> DividedResult
dividedBy num denom
 | denom == 0 = DividedByZero
 | otherwise = Result (go num denom 0)
   where go n d count
          | d < 0 && n > 0 = negate (go n (negate d) count)
          | d > 0 && n < 0 = negate (go (negate n) d count)
          | abs n < abs d = count
          | otherwise = go (n - d) d (count + 1)

-- McCarthy 91 function
-- Is it OK to use a concrete Num type?
mc91 :: Integer -> Integer

mc91 x
  | x > 100 = x - 10
  | otherwise = mc91 . mc91 $ (x + 11)
