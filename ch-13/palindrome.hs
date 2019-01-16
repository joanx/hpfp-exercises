import Control.Monad
import System.Exit (exitSuccess)
import Data.Char (toLower)

-- Is there a way to putStrLn "Nope!" *then* return ?
palindrome :: IO ()
palindrome = forever $ do
  line1 <- getLine
  case ((convertSentence line1) == (reverse $ convertSentence line1)) of
    True -> putStrLn "It's a palindrome!"
    False -> exitSuccess

convertSentence :: [Char] -> [Char]
convertSentence s = concat $ words s
