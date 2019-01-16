module Cipher where

import Data.Char

-- CAESAR
-- Translate character specified number of spaces
translateCharCaesar :: Int -> Char -> Char
translateCharCaesar n c
  | isUpper c = chr (ord c + n `mod` (ord 'A'))
  | isLower c = chr (ord c + n `mod` (ord 'a'))
  | otherwise = c

untranslateCharCaeasar :: Int -> Char -> Char
untranslateCharCaeasar n c
  | isUpper c = chr (ord c - n `mod` (ord 'A'))
  | isLower c = chr (ord c - n `mod` (ord 'a'))
  | otherwise = c

caesarCipher :: Int -> [Char] -> [Char]
caesarCipher n = map (\x -> translateCharCaesar n x)

unCaesar :: Int -> [Char] -> [Char]
unCaesar n = map (\x -> untranslateCharCaeasar n x)

caesarMain :: IO()
caesarMain = do
  putStr "Target"
  word <- getLine
  putStr "Encoding key"
  shiftChar <- getLine
  putStrLn $ caesarCipher (read shiftChar) word

-- VIGNERE
-- Translate character specified number of spaces
translateCharVignere :: Char -> Char -> Char
translateCharVignere k c = chr (baseOrd + shiftedOrd `mod` 26)
  where
    baseOrd = if isUpper c then ord 'A' else ord 'a'
    shiftedOrd = normalizeOrd c + normalizeOrd k

normalizeOrd :: Char -> Int
normalizeOrd c
  | isUpper c = ord c `mod` ord 'A'
  | isLower c = ord c `mod` ord 'a'
  | otherwise = ord c

vignereCipher :: [Char] -> [Char] -> [Char]
vignereCipher _ "" = ""
vignereCipher [] target = target
vignereCipher key (' ':xs) = vignereCipher key xs
vignereCipher (x:xs) (y:ys) = (translateCharVignere x y) : (vignereCipher (xs ++ [x]) ys)

vignereMain :: IO()
vignereMain = do
  putStr "Target"
  word <- getLine
  putStr "Encoding key"
  shiftKey <- getLine
  putStrLn $ vignereCipher shiftKey word
