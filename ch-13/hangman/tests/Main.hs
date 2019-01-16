module Main where

import Hangman hiding (main)
import Test.Hspec
import Data.Maybe (catMaybes)

-- Some confusion around when we want to use quickCheck prop_something
-- vs. property $ (lambda)

-- Why are we encouraged to test handleGuess?
-- Best way to handle testing IO? Do we want to test string output AND returned puzzle?

-- when do we use a generator function vs creating an arbitrary typeclass?
-- Do we just want an Arbitrary instance when we want repeated access to a canonical generator?

-- Note: ended up taking simple approach to unit testing here - got a little stuck on property testing
main :: IO ()
main = hspec $ do
  describe "fillInCharacter" $ do
    it "should add incorrect guesses to guesses" $ do
      let puzzle = Puzzle "cat" [Nothing, Nothing, Nothing] []
      let guess = 'z'
      let (Puzzle _ _ guesses) = fillInCharacter puzzle guess
      (guess `elem` guesses) `shouldBe` True


    it "should add correct guesses to filled-in word" $ do
      let puzzle = Puzzle "cat" [Nothing, Nothing, Nothing] []
      let guess = 'c'
      let (Puzzle _ filledIn _) = fillInCharacter puzzle guess
      (guess `elem` (catMaybes filledIn)) `shouldBe` True
