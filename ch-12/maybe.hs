-- >>> isJust (Just 1)
-- True
-- >>> isJust Nothing
-- False
isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust Nothing = False
-- >>> isNothing (Just 1)
-- False
-- >>> isNothing Nothing
-- True
isNothing :: Maybe a -> Bool
isNothing (Just _) = False
isNothing Nothing = True

-- >>> mayybee 0 (+1) Nothing
-- 0
-- >>> mayybee 0 (+1) (Just 1)
-- 2
mayybee :: b -> (a -> b) -> Maybe a -> b
mayybee _ f (Just a) = f a
mayybee defaultVal _ Nothing = defaultVal
-- >>> fromMaybe 0 Nothing
-- 0
-- >>> fromMaybe 0 (Just 1)
-- 1
fromMaybe :: a -> Maybe a -> a
fromMaybe defaultVal maybeVal = mayybee defaultVal id maybeVal

-- Try writing it in terms of the maybe catamorphism

-- >>> listToMaybe [1, 2, 3]
-- Just 1
-- >>> listToMaybe []
-- Nothing
listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (x:_) = Just x

-- >>> maybeToList (Just 1)
-- [1]
-- >>> maybeToList Nothing
-- []
maybeToList :: Maybe a -> [a]
maybeToList (Just a) = [a]
maybeToList Nothing = []

-- >>> catMaybes [Just 1, Nothing, Just 2]
-- [1, 2]
-- >>> catMaybes [Nothing, Nothing, Nothing]
-- []
catMaybes :: [Maybe a] -> [a]
catMaybes = concatMap maybeToList

-- >>> flipMaybe [Just 1, Just 2, Just 3]
-- Just [1, 2, 3]
-- >>> flipMaybe [Just 1, Nothing, Just 3]
-- Nothing
flipMaybe :: [Maybe a] -> Maybe [a]
flipMaybe [] = Just []
flipMaybe (Nothing:_) = Nothing
flipMaybe ((Just a):xs) = case flipMaybe xs of
  Just ys -> Just (a:ys)
  Nothing -> Nothing
