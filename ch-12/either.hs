lefts' :: [Either a b] -> [a]
lefts' [] = []
lefts' (x:xs) = case x of
  Left a -> [a] ++ lefts' xs
  Right _ -> lefts' xs

rights' :: [Either a b] -> [b]
rights' [] = []
rights' (x:xs) = case x of
  Right b -> [b] ++ rights' xs
  Left _ -> rights' xs

partitionEithers' :: [Either a b] -> ([a], [b])
partitionEithers' [] = ([], [])
partitionEithers' (x:xs) = case x of
  Left a -> addLeft a (partitionEithers' xs)
  Right b -> addRight b (partitionEithers' xs)

addLeft :: a -> ([a], [b]) -> ([a], [b])
addLeft val (a, b) = (val:a, b)

addRight :: b -> ([a], [b]) -> ([a], [b])
addRight val (a, b) = (a, val:b)

eitherMaybe' :: (b -> c) -> Either a b -> Maybe c
eitherMaybe' f e = case e of
  Left _ -> Nothing
  Right b -> Just (f b)

either' :: (a -> c) -> (b -> c) -> Either a b -> c
either' fLeft fRight e = case e of
  Left a -> fLeft a
  Right b -> fRight b

eitherMaybe'' :: (b -> c) -> Either a b -> Maybe c
eitherMaybe'' fRight = either' (\_ -> Nothing) (\x -> Just (fRight x))
