module Reverse where

rvs :: String -> String
rvs x = concat [(drop 9 x), " ", (take 2 (drop 6 x)), " ", (take 5 x)]

main :: IO()
main = print $ rvs "Curry is awesome"
