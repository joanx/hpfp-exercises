module Main where

import Test.Hspec
import Test.QuickCheck
import Data.List (sort)

-- for a function
half x = x / 2
-- this property should hold
halfIdentity = (*2) . half

-- for any list you apply sort to
-- this property should hold
listOrdered :: (Ord a) => [a] -> Bool
listOrdered xs =
  snd $ foldr go (Nothing, True) xs
  where go _ status@(_, False) = status
        go y (Nothing, t) = (Just y, t)
        go y (Just x, t) = (Just y, x >= y)

plusAssociative x y z = x + (y + z) == (x + y) + z
plusCommutative x y = x + y == y + x

multAssociative x y z = x * (y * z) == (x * y) * z
multCommutative x y = x * y == y * x

reverseList :: [Int] -> Bool
reverseList list = (reverse . reverse $ list) == list

twice f = f . f
fourTimes = twice . twice

main :: IO()
main = hspec $ do
  describe "half" $ do
    it "should return half" $ do
      (half 2) `shouldBe` 1

    it "should return identity when multiplied by 2" $ do
      ((*2) . half $ 4 )`shouldBe` 4

  describe "DataList.sort" $ do
    it "should sort a list" $ do
      property $ \xs -> listOrdered $ sort (xs :: [Int])

  describe "addition" $ do
    it "should be associative" $ do
      property $ \x y z -> plusAssociative (x :: Int) (y :: Int) (z :: Int)

    it "should be comutative" $ do
      property $ \x y -> plusCommutative (x :: Int) (y :: Int)

  describe "multiplication" $ do
    it "should be associative" $ do
      property $ \x y z -> multAssociative (x :: Int) (y :: Int) (z :: Int)

    it "should be commutative" $ do
      property $ \x y -> multCommutative (x :: Int) (y :: Int)

  -- How to write without fail on 0?
  describe "quot rem" $ do
    it "should do the thing" $ do
      property $ \x (NonZero y) -> (quot x y)*y + (rem x y) == (x :: Int)

    it "should do the other thing" $ do
      property $ \x (NonZero y) -> (div x y)*y + (mod x y) == (x :: Int)

  describe "reverse" $ do
    it "should return the id after reversing twice" $ do
      property $ reverseList

  -- the @[Int] xs - is that notation just used to specify type?
  -- Is that an alternative to (x :: [Int])
  describe "idempotence" $ do
    it "sort is idempotent after 2x" $ property $ \x -> sort x == twice sort (x :: [Int])
    it "sort is idempotent after 4x" $ property $ \x -> twice sort x == fourTimes sort (x :: [Int])


-- Make a Gen random generator
data Fool = Fulse | Frue deriving (Eq, Show)
-- Equal probabilities
-- instance Arbitrary Fool where
--   arbitrary = oneOf [return Fulse, return Frue]

-- 2/3s chance of Fulse, 1/3 chance of Frue.
-- Question for Chris: why pure instead of return?
instance Arbitrary Fool where
  arbitrary = frequency [(1, return Fulse), (2, return Frue)]
