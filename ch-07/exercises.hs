-- Case practice

functionC x y =
  case (x > y) of
    True -> x
    False -> y

ifEvenAdd2 n =
  case even n of
    True -> n + 2
    False -> n

nums x =
  case compare x 0 of
    LT -> -1
    GT -> 1
    EQ -> 0

-- Chapter Exercises

-- Old
tensDigit :: Integral a => a -> a
tensDigit x = d
  where xLast = x `div` 10
        d = xLast `mod` 10

-- New - same type signature
tensDigitNew :: Integral a => a -> a
tensDigitNew x = d
  where xLast = x `div` 10
        (_, d) = xLast `divMod` 10

hundredsDigit :: Integral a => a -> a
hundredsDigit x = d2
  where xLast = x `div` 100
        (_, d2) = xLast `divMod` 10

foldBool :: a -> a -> Bool -> a
foldBool x y b =
  case b of
    True -> x
    False -> y


foldBool2 :: a -> a -> Bool -> a
foldBool2 x y b
  | bool = x
  | otherwise = y

foldBool3 :: a -> a -> Bool -> a
foldBool3 x y True = x
foldBool3 x y False = y

g :: (a -> b) -> (a, c) -> (b, c)
g f (a, c) = (f a, c)
