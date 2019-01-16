-- Exercises: heavy lifting

-- Prelude> a
-- [2]
a :: [Int]
a = fmap (+1) $ read "[1]" :: [Int]

-- Prelude> b
-- Just ["Hi,lol","Hellolol"]
b :: Maybe [[Char]]
b = (fmap . fmap) (++ "lol") (Just ["Hi,", "Hello"])

-- Prelude> c 1
-- -2
c :: Integer -> Integer
c = (*2) . (\x -> x - 2)

-- Prelude> d 0
-- "1[0,1,2,3]"
d :: Integer -> [Char]
d = ((return '1' ++) . show) . (\x -> [x, 1..3])

-- Prelude> e
-- 3693
e :: IO Integerheav
e = let ioi = readIO "1" :: IO Integer
        changed = fmap (read . ("123"++) . show) ioi
    in fmap (*3) changed
