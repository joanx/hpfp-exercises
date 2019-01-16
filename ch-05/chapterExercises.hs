-- Write a type signature

functionH :: [a] -> a
functionH (x:_) = x

functionC :: (Ord a) => a -> a -> Bool
functionC x y = if (x > y) then True else False

functionS :: (x, y) -> y
functionS (x, y) = y

-- Given a type, write the function

i :: a -> a
i x = x

c :: a -> b -> a
c a _ = a

c' :: a -> b -> b
c' _ b = b

r :: [a] -> [a]
r x = reverse x

co :: (b -> c) -> (a -> b) -> a -> c
co bToC aToB a = bToC (aToB a)

a :: (a -> c) -> a -> a
a _ y = y

a' :: (a -> b) -> a -> b
a' aToB a = aToB a
