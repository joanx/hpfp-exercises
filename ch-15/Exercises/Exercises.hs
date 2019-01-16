-- mappend needs to be defined in Semigroup separately, see:
-- https://stackoverflow.com/questions/52237895/could-not-deduce-semigroup-optional-a-arising-from-the-superclasses-of-an-in
module Exercises where

import Test.QuickCheck hiding (Failure, Success)

-- Intermediate exercises

monoidAssoc :: (Eq m, Monoid m) => m -> m -> m -> Bool
monoidAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

monoidLeftIdentity :: (Eq m, Monoid m) => m -> Bool
monoidLeftIdentity a = (mempty <> a) == a

monoidRightIdentity :: (Eq m, Monoid m) => m -> Bool
monoidRightIdentity a = (a <> mempty) == a

data Optional a =
  Nada
  | Only a
  deriving (Eq, Show)

genOnly :: Arbitrary a => Gen (Optional a)
genOnly = do
  a <- arbitrary
  return (Only a)

instance Arbitrary a => Arbitrary (Optional a) where
  arbitrary = frequency [(1, return Nada), (2, genOnly)]

instance Monoid a => Monoid (Optional a) where
  mempty = Nada

instance Semigroup a => Semigroup (Optional a) where
  Nada <> only = only
  only <> Nada = only
  (Only a) <> (Only b) = Only (a <> b)

newtype First' a =
  First' { getFirst' :: Optional a }
  deriving (Eq, Show)

instance Monoid a => Monoid (First' a) where
  mempty = First' Nada

instance Semigroup a => Semigroup (First' a) where
  First' (Only a) <> _ = First' (Only a)
  _ <> b = b

-- Is there a way to do this inline inside the arbitrary instance definition?
genFirst' :: Arbitrary a => Gen (First' a)
genFirst' = do
  a <- arbitrary
  return (First' a)

instance Arbitrary a => Arbitrary (First' a) where
  arbitrary = genFirst'

firstMappend :: Semigroup a => First' a -> First' a -> First' a
firstMappend (First' a) (First' b) = First' (a <> b)

type FirstMappend =
     First' String
  -> First' String
  -> First' String
  -> Bool

type FstId = First' String -> Bool

-- Chapter exercises: Semigroup
semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

-- 1. Trivial
data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
  _ <> _ = Trivial

instance Monoid Trivial where
  mempty = Trivial
  mappend = (<>)

instance Arbitrary Trivial where
  arbitrary = return Trivial

type TrivialAssoc = Trivial -> Trivial -> Trivial -> Bool

-- 2. Identity
newtype Identity a = Identity a deriving (Eq, Show)

instance (Semigroup a) => Semigroup (Identity a) where
  Identity a <> Identity b = Identity (a <> b)

-- Why is mempty = Identity (mempty a) not valid? Is the "a" inferred?
instance (Monoid a) => Monoid (Identity a) where
  mempty = Identity $ mempty
  mappend = (<>)

genIdentity :: Arbitrary a => Gen (Identity a)
genIdentity = do
  a <- arbitrary
  return (Identity a)

-- WHy is this Arbitrary inheritance necessary given we also specify that relationship in genIdentity?
-- Chris: You can think of typeclass constraints as implicit function arguments.
-- They're implicit because ghc does all the passing for us, but we still have to declare that they must be passed.
instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = genIdentity

type IdentityAssoc = (Identity String) -> (Identity String) -> (Identity String) -> Bool

-- 3. Two (same application for Three and Four)

data Two a b = Two a b deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
  Two a b <> Two a' b' = Two (a <> a') (b <> b')

instance (Monoid a, Monoid b) => Monoid (Two a b) where
  mempty = Two mempty mempty
  mappend = (<>)

genTwo :: (Arbitrary a, Arbitrary b) => Gen (Two a b)
genTwo = do
  a <- arbitrary
  b <- arbitrary
  return (Two a b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = genTwo

type TwoAssoc = (Two String String) -> (Two String String) -> (Two String String) -> Bool

-- 6. BoolConj (omitting BoolDisj - similar implementation but different mappend outcomes)

newtype BoolConj = BoolConj Bool deriving (Eq, Show)

instance Semigroup BoolConj where
  BoolConj a <> BoolConj b = BoolConj (a && b)

instance Monoid BoolConj where
  mempty = BoolConj True
  mappend = (<>)

instance Arbitrary BoolConj where
  arbitrary = elements [BoolConj True, BoolConj False]

type BoolConjAssoc = BoolConj -> BoolConj -> BoolConj -> Bool

--  8. Or

data Or a b = Fst a | Snd b deriving (Eq, Show)

instance Semigroup (Or a b) where
  Snd a <> _ = Snd a
  _ <> b = b

instance Monoid a => Monoid (Or a b) where
  mempty = Fst mempty
  mappend = (<>)

genOr :: (Arbitrary a, Arbitrary b) => Gen (Or a b)
genOr = do
  a <- arbitrary
  b <- arbitrary
  oneof [return $ Fst a, return $ Snd b]

instance (Arbitrary a, Arbitrary b) => Arbitrary (Or a b) where
  arbitrary = genOr

type OrAssoc = (Or String String) -> (Or String String) -> (Or String String) -> Bool

-- 9. Combine
newtype Combine a b = Combine { unCombine :: (a -> b) }

instance (Semigroup b) => Semigroup (Combine a b) where
  Combine f <> Combine g = Combine (\x -> (f x) <> (g x))

instance (Monoid b) => Monoid (Combine a b) where
  mempty = Combine (\_ -> mempty)
  mappend = (<>)

instance (CoArbitrary a, Arbitrary b) => Arbitrary (Combine a b) where
  arbitrary = do
    a <- arbitrary
    return (Combine a)

-- 10. Comp
newtype Comp a = Comp { unComp :: (a -> a) }

instance (Semigroup a) => Semigroup (Comp a) where
  Comp f <> Comp g = Comp (f . g)

instance (Monoid a) => Monoid (Comp a) where
  mempty = Comp (id)
  mappend = (<>)

-- 11. Validation - return accumulated failures
data Validation a b = Failure a | Success b deriving (Eq, Show)

instance Semigroup a => Semigroup (Validation a b) where
  Failure x <> Failure y = Failure (x <> y)
  Failure x <> Success _ = Failure x
  Success _ <> Failure y = Failure y
  Success x <> Success _ = Success x

genValidation :: (Arbitrary a, Arbitrary b) => Gen (Validation a b)
genValidation = do
  a <- arbitrary
  b <- arbitrary
  oneof [return $ Failure a, return $ Success b]

instance (Arbitrary a, Arbitrary b) => Arbitrary (Validation a b) where
  arbitrary = genValidation

type ValidationAssoc = (Validation String String) -> (Validation String String) -> (Validation String String) -> Bool

-- 12. AccumulateRight -return accumulated successes
newtype AccumulateRight a b = AccumulateRight (Validation a b) deriving (Eq, Show)

instance Semigroup b => Semigroup (AccumulateRight a b) where
  AccumulateRight (Failure x) <> AccumulateRight (Failure _) = AccumulateRight (Failure x)
  AccumulateRight (Failure _) <> AccumulateRight (Success y) = AccumulateRight (Success y)
  AccumulateRight (Success x) <> AccumulateRight (Failure _) = AccumulateRight (Success x)
  AccumulateRight (Success x) <> AccumulateRight (Success y) = AccumulateRight (Success (x <> y))

genAccumulateRight :: (Arbitrary a, Arbitrary b) => Gen (AccumulateRight a b)
genAccumulateRight = do
  a <- arbitrary
  b <- arbitrary
  oneof [return $ AccumulateRight (Failure a), return $ AccumulateRight (Success b)]

instance (Arbitrary a, Arbitrary b) => Arbitrary (AccumulateRight a b) where
  arbitrary = genAccumulateRight

type AccumulateRightAssoc = (AccumulateRight String String) -> (AccumulateRight String String) -> (AccumulateRight String String) -> Bool

-- 13. AccumulateBoth - return accumulated successes where existent, otherwise return accumulated failures

newtype AccumulateBoth a b = AccumulateBoth (Validation a b) deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (AccumulateBoth a b) where
  AccumulateBoth (Failure x) <> AccumulateBoth (Failure y) = AccumulateBoth (Failure (x <> y))
  AccumulateBoth (Failure _) <> AccumulateBoth (Success y) = AccumulateBoth (Success y)
  AccumulateBoth (Success x) <> AccumulateBoth (Failure _) = AccumulateBoth (Success x)
  AccumulateBoth (Success x) <> AccumulateBoth (Success y) = AccumulateBoth (Success (x <> y))

genAccumulateBoth :: (Arbitrary a, Arbitrary b) => Gen (AccumulateBoth a b)
genAccumulateBoth = do
  a <- arbitrary
  b <- arbitrary
  oneof [return $ AccumulateBoth (Failure a), return $ AccumulateBoth (Success b)]

instance (Arbitrary a, Arbitrary b) => Arbitrary (AccumulateBoth a b) where
  arbitrary = genAccumulateBoth

type AccumulateBothAssoc = (AccumulateBoth String String) -> (AccumulateBoth String String) -> (AccumulateBoth String String) -> Bool

-- Mem
newtype Mem s a = Mem { runMem :: s -> (a,s) }

-- From Chris: You can't pattern match on a lambda.
-- You can name Mem's argument, and, since it's a function, the only interesting thing you can do with it is apply it:
-- First attempt:
-- instance Semigroup a => Semigroup (Mem s a) where
--   Mem f <> Mem g = Mem $ \x -> ((fst $ f x) <> (fst $ g x), (snd $ f (snd $ g x)))
-- A more Chris-like solution:
instance Semigroup a => Semigroup (Mem s a) where
  Mem f <> Mem g = Mem $ \x ->
    let
      (a1, s1) = g x
      (a2, s2) = f s1
    in
      (a1 <> a2, s2)

instance Monoid a => Monoid (Mem s a) where
  mempty = Mem $ \s -> (mempty, s)
  mappend = (<>)

f' = Mem $ \s -> ("hi", s + 1)

-- A correct Monoid for Mem should, given the above code, get the following output:
-- Prelude> main
-- ("hi",1)
-- ("hi",1)
-- ("",0)
-- True
-- True

main :: IO ()
main = do
  print $ runMem (f' <> mempty) 0
  print $ runMem (mempty <> f') 0
  print $ (runMem mempty 0 :: (String, Int))
  print $ runMem (f' <> mempty) 0 == runMem f' 0
  print $ runMem (mempty <> f') 0 == runMem f' 0
  quickCheck (monoidAssoc :: FirstMappend)
  quickCheck (monoidLeftIdentity :: FstId)
  quickCheck (monoidRightIdentity :: FstId)
  quickCheck (semigroupAssoc :: TrivialAssoc)
  quickCheck (monoidLeftIdentity :: Trivial -> Bool)
  quickCheck (monoidRightIdentity :: Trivial -> Bool)
  quickCheck (semigroupAssoc :: IdentityAssoc)
  quickCheck (monoidLeftIdentity :: Identity String -> Bool)
  quickCheck (monoidRightIdentity :: Identity String -> Bool)
  quickCheck (semigroupAssoc :: TwoAssoc)
  quickCheck (monoidLeftIdentity :: Two String String -> Bool)
  quickCheck (monoidRightIdentity :: Two String String -> Bool)
  quickCheck (semigroupAssoc :: BoolConjAssoc)
  quickCheck (monoidLeftIdentity :: BoolConj -> Bool)
  quickCheck (monoidRightIdentity :: BoolConj -> Bool)
  quickCheck (semigroupAssoc :: OrAssoc)
  quickCheck (monoidLeftIdentity :: Or String String -> Bool)
  quickCheck (monoidRightIdentity :: Or String String -> Bool)
  quickCheck (semigroupAssoc :: ValidationAssoc)
  quickCheck (semigroupAssoc :: AccumulateRightAssoc)
  quickCheck (semigroupAssoc :: AccumulateBothAssoc)
