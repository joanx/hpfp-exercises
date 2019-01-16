import Data.Char
-- This should return True if (and only if) all the values in the
-- first list appear in the second list, though they need not be
-- contiguous.
isSubsequenceOf :: (Eq a) => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf a@(x:xs) b@(y:ys)
  | x == y = isSubsequenceOf xs ys
  | otherwise = isSubsequenceOf a ys

-- Split a sentence into words, then tuple each word with the capi-
-- talized form of each.
capitalizeWords :: String -> [(String, String)]
capitalizeWords a@(x:xs) = map (\word@(y:ys) -> (word, capitalizeWord word)) (words a)

capitalizeWord :: String -> String
capitalizeWord (x:xs) = toUpper x : xs

-- ?????
capitalizeParagraph :: String -> String
capitalizeParagraph = undefined

--Hutton's Razor

data Expr = Lit Integer
            | Add Expr Expr

eval :: Expr -> Integer
eval expr = case expr of
  Lit n -> n
  Add exp1 exp2 -> eval exp1 + eval exp2

printExpr :: Expr -> String
printExpr expr = case expr of
  Lit n -> show n
  Add exp1 exp2 -> (printExpr exp1 ++ "+" ++ printExpr exp2)
