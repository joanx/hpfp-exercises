{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE FlexibleInstances #-}

module Exercises where

import Test.QuickCheck

-- QuickCheck properties
functorIdentity :: (Functor f, Eq (f a)) => f a -> Bool
functorIdentity f = fmap id f == f

functorCompose :: (Eq (f c), Functor f) =>
                      (a -> b)
                   -> (b -> c)
                   -> f a
                   -> Bool
functorCompose f g x = (fmap g (fmap f x)) == (fmap (g . f) x)

functorCompose' :: (Eq (f c), Functor f) =>
                        f a
                     -> Fun a b
                     -> Fun b c
                     -> Bool
functorCompose' x (Fun _ f) (Fun _ g) = (fmap (g . f) x) == (fmap g . fmap f $ x)

-- Exercises: Instances of Func
-- 1. Identity
newtype Identity a = Identity a deriving (Eq, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

type IdToId = Fun String String
type IdFC = Identity String -> IdToId -> IdToId -> Bool

-- 2. Pair
data Pair a = Pair a a deriving (Eq, Show)

instance Functor Pair where
  fmap f (Pair a b) = Pair (f a) (f b)

instance (Arbitrary a) => Arbitrary (Pair a) where
  arbitrary = do
    a <- arbitrary
    return (Pair a a)

type PairToPair = Fun String String
type PairFC = (Pair String) -> PairToPair -> PairToPair -> Bool

-- 3. Two
data Two a b = Two a b deriving (Eq, Show)

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b)

type TwoToTwo = Fun String String
type TwoFC = (Two String String) -> TwoToTwo -> TwoToTwo -> Bool

--4. Three
data Three a b c = Three a b c deriving (Eq, Show)

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)

type ThreeToThree = Fun String String
type ThreeFC = (Three String String String) -> ThreeToThree -> ThreeToThree -> Bool

--5. AnotherThree
data Three' a b = Three' a b b deriving (Eq, Show)

instance Functor (Three' a) where
  fmap f (Three' a b c) = Three' a (f b) (f c)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three' a b c)

type AnotherThreeToAnotherThree = Fun String String
type AnotherThreeFC = (Three' String String) -> AnotherThreeToAnotherThree -> AnotherThreeToAnotherThree -> Bool

--6. Four
data Four a b c d = Four a b c d deriving (Eq, Show)

instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    return (Four a b c d)

type FourToFour = Fun String String
type FourFC = (Four String String String String) -> FourToFour -> FourToFour -> Bool

--7. Four'
data Four' a b = Four' a a a b deriving (Eq, Show)

instance Functor (Four' a) where
  fmap f (Four' a b c d) = Four' a b c (f d)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    return (Four' a b c d)

type Four'ToFour' = Fun String String
type Four'FC = (Four' String String) -> Four'ToFour' -> Four'ToFour' -> Bool

-- 8. cannot implement functor for data Trivial = Trivial since has kind *

-- CHAPTER EXERCISES
-- Rearrange the arguments to the type constructor of the datatype so the Functor instance works.

data Sum a b = First b | Second a
instance Functor (Sum e) where
  fmap f (First a) = First (f a)
  fmap _ (Second b) = Second b

data Company a b c = DeepBlue a b | Something c
instance Functor (Company e e') where
  fmap f (Something b) = Something (f b)
  fmap _ (DeepBlue a c) = DeepBlue a c

data More b a = L a b a | R b a b deriving (Eq, Show)
instance Functor (More x) where
  fmap f (L a b a') = L (f a) b (f a')
  fmap f (R b a b') = R b (f a) b'

-- Write Functor instances for the following datatypes.

data Quant a b = Finance | Desk a | Bloor b
instance Functor (Quant a) where
  fmap _ Finance = Finance
  fmap _ (Desk a) = Desk a
  fmap f (Bloor b) = Bloor (f b)

data K a b = K a
instance Functor (K a) where
  fmap _ (K a) = K a

-- Why parse error for fmap f (Flip $ K a)? The $ doesn't seem to replace parens
-- correctly in my fmap statements
newtype Flip f a b = Flip (f b a) deriving (Eq, Show)
instance Functor (Flip K a) where
  fmap f (Flip (K a))= Flip $ K $ f a

data EvilGoateeConst a b = GoatyConst b
instance Functor (EvilGoateeConst a) where
  fmap f (GoatyConst b) = GoatyConst $ f b

-- Broadly speaking, I think I'm a bit confused about the need to specify
-- f's Functor instance. When I don't have that, I get:
-- cannot construct the infinite type: b ~ g b
-- How can we be reasonably sure that (f a) in data constructor
-- LiftItOut (f a) is even a valid functor?
data LiftItOut f a = LiftItOut (f a)
instance (Functor f) => Functor (LiftItOut f) where
  fmap g (LiftItOut f) = LiftItOut $ fmap g f

data Parappa f g a = DaWrappa (f a) (g a)
instance (Functor f, Functor g) => Functor (Parappa f g) where
  fmap h (DaWrappa f g) = DaWrappa (fmap h f) (fmap h g)

data IgnoreOne f g a b = IgnoringSomething (f a) (g b)
instance (Functor g) => Functor (IgnoreOne f g a) where
  fmap h (IgnoringSomething x y) = IgnoringSomething x $ fmap h y

data Notorious g o a t = Notorious (g o) (g a) (g t)
instance (Functor g) => Functor (Notorious g o a) where
  fmap f (Notorious go ga gt) = Notorious go ga $ fmap f gt

data List a = Nil | Cons a (List a)
instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a list) = Cons (f a) $ fmap f list

data GoatLord a =
     NoGoat
     | OneGoat a
     | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
instance Functor GoatLord where
  fmap _ NoGoat = NoGoat
  fmap f (OneGoat a) = OneGoat $ f a
  fmap f (MoreGoats a b c) =
    MoreGoats (fmap f a) (fmap f b) (fmap f c)

data TalkToMe a =
     Halt
     | Print String a
     | Read (String -> a)
instance Functor TalkToMe where
  fmap _ Halt = Halt
  fmap f (Print s a) = Print s $ f a
  fmap f (Read g) = Read (f . g)

main :: IO ()
main = do
  quickCheck $ \x -> functorIdentity (x :: Identity String)
  quickCheck (functorCompose' :: IdFC)
  quickCheck $ \x -> functorIdentity (x :: Pair String)
  quickCheck (functorCompose' :: PairFC)
  quickCheck $ \x -> functorIdentity (x :: Two String String)
  quickCheck (functorCompose' :: TwoFC)
  quickCheck $ \x -> functorIdentity (x :: Three String String String)
  quickCheck (functorCompose' :: ThreeFC)
  quickCheck $ \x -> functorIdentity (x :: Three' String String)
  quickCheck (functorCompose' :: AnotherThreeFC)
  quickCheck $ \x -> functorIdentity (x :: Four String String String String)
  quickCheck (functorCompose' :: FourFC)
  quickCheck $ \x -> functorIdentity (x :: Four' String String)
  quickCheck (functorCompose' :: Four'FC)
