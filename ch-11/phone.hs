import Data.List
import Data.Char
type DaPhone = [Key]
type Key = (Char, [Char])

-- Convert the following conversations into the keypresses re-
-- quired to express them.
convo :: [String]
convo =
  ["Wanna play 20 questions",
  "Ya",
  "U 1st haha",
  "Lol ok. Have u ever tasted alcohol lol",
  "Lol ya",
  "Wow ur cool haha. Ur turn",
  "Ok. Do u think I am pretty Lol",
  "Lol ya",
  "Haha thanks just making sure rofl ur turn"]

-- validButtons = "1234567890*#"
type Digit = Char
-- Valid presses: 1 and up
type Presses = Int

phone :: DaPhone
phone = [
    ('1', "1")
  , ('2', "2abc")
  , ('3', "3def")
  , ('4', "4ghi")
  , ('5', "5jkl")
  , ('6', "6mno")
  , ('7', "7pqrs")
  , ('8', "8tuv")
  , ('9', "9wxyz")
  , ('0', "0+_")
  , ('*', "*+_")
  , ('#', "#.,")
  ]

-- assuming the default phone definition
-- 'a' -> [('2', 1)]
-- 'A' -> [('*', 1), ('2', 1)]

reverseTaps :: DaPhone -> Char -> [(Digit, Presses)]
reverseTaps [] _ = []
reverseTaps ((d, str):xs) c = case elemIndex (toLower c) str of
  Just n -> if isUpper c then [('*', 1), (d, n + 1)] else [(d, n + 1)]
  Nothing -> reverseTaps xs c

cellPhonesDead :: DaPhone -> String -> [(Digit, Presses)]
cellPhonesDead phone string = concatMap (reverseTaps phone) string

fingerTaps :: [(Digit, Presses)] -> Presses
fingerTaps = foldl (\acc (_, p) -> acc + p) 0

mostPopularLetter :: String -> Char
mostPopularLetter = undefined

coolestLtr :: [String] -> Char
coolestLtr = undefined

coolestWord :: [String] -> String
coolestWord = undefined
