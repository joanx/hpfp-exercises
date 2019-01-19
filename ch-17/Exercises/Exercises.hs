module Exercises where
import Data.List (elemIndex)

-- Exercises: Lookups
-- 1.
added :: Maybe Integer
added = (+3) <$> (lookup 3 $ zip [1, 2, 3] [4, 5, 6])

-- 2.
y :: Maybe Integer
y = lookup 3 $ zip [1, 2, 3] [4, 5, 6]

z :: Maybe Integer
z = lookup 2 $ zip [1, 2, 3] [4, 5, 6]

tupled :: Maybe (Integer, Integer)
tupled = (,) <$> y <*> z

-- 3.
x' :: Maybe Int
x' = elemIndex 3 [1, 2, 3, 4, 5]

y' :: Maybe Int
y' = elemIndex 4 [1, 2, 3, 4, 5]

max' :: Int -> Int -> Int
max' = max

maxed :: Maybe Int
maxed = max' <$> x' <*> y'

-- 4.
-- Weird behavior - returns 2nd element of tuple ?
xs' = [1, 2, 3]
ys' = [4, 5, 6]

x'' :: Maybe Integer
x'' = lookup 3 $ zip xs' ys'

y'' :: Maybe Integer
y'' = lookup 2 $ zip xs' ys'

summed :: Maybe Integer
summed = fmap sum $ (,) <$> x'' <*> y''

-- Exercises: Identity Instance
newtype Identity a = Identity a deriving (Eq, Ord, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance Applicative Identity where
  pure a = Identity a
  (<*>) (Identity f) (Identity a) = Identity (f a)

-- Exercises: Constant Instance
newtype Constant a b = Constant { getConstant :: a } deriving (Eq, Ord, Show)

instance Functor (Constant a) where
  fmap _ (Constant a) = Constant a

instance Monoid a => Applicative (Constant a) where
  pure _ = Constant mempty
  (<*>) (Constant a) (Constant b) = Constant (a <> b)

-- List applicative exercise
data List a = Nil | Cons a (List a) deriving (Eq, Show)

instance Semigroup (List a) where
  Nil <> ys = ys
  Cons x xs <> ys = Cons x (xs <> ys)

instance Monoid (List a) where
  mempty = Nil

instance Functor List where
  fmap _ Nil = Nil
  fmap Nil _ = Nil
  fmap f (Cons x xs) = Cons (f x) (fmap f xs)

instance Applicative List where
  pure a = Cons a Nil
  (<*>) Nil _ = Nil
  (<*>) (Cons f fs) xs = (fmap f xs) <> (fs <*> xs)

-- Ziplist applicative exercise
newtype ZipList' a = ZipList' (List a) deriving (Eq, Show)

instance Eq a => EqProp (ZipList' a) where
  xs =-= ys = xs' `eq` ys'
    where xs' = let (ZipList' l) = xs
                in take' 3000 l
          ys' = let (ZipList' l) = ys
                in take' 3000 l

instance Functor ZipList' where
  fmap f (ZipList' xs) = ZipList' $ fmap f xs

instance Applicative ZipList' where
  pure x = ZipList (repeat x)
  ZipList fs <*> ZipList xs = ZipList (zipWith (\f x -> f x) fs xs)

-- Exercise: Variations on Either
data Validation e a
  = Failure e
  | Success a
  deriving (Eq, Show)

instance Functor (Validation e) where
  fmap f (Success a) = Success (f a)
  fmap _ (Failure e) = Failure e

instance Monoid e => Applicative (Validation e) where
  pure = Success
  (<*>) (Success f) (Success x) = Success (f x)
  (<*>) (Failure x) (Failure y) = Failure (x <> y)
  (<*>) _ (Failure x) = Failure x
  (<*>) (Failure y) _ = Failure y

-- Chapter Exercises
-- Given a type that has an instance of Applicative, specialize the types of the methods

-- []

-- pure :: a -> [a]
-- (<*>) :: [(a -> b)] -> [a] -> [b]

-- IO

-- pure :: a -> IO a
-- (<*>) :: IO (a -> b) -> IO a -> IO b

-- (,) a

-- pure :: a -> (e, a)
-- (<*>) :: (e, (a -> b)) -> (e, a) -> (e, b)

-- (->) e

-- pure :: a -> (e -> a)
-- (<*>) :: (e -> (a -> b)) -> (e -> a) -> (e -> b)

-- Pair

data Pair a = Pair a a deriving Show

instance Functor Pair where
  fmap f (Pair a b) = Pair (f a) (f b)

instance Applicative Pair where
  pure a = Pair a a
  (Pair f g) <*> (Pair a b) = Pair (f a) Pair (g b)

-- Two

data Two a b = Two a b

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

instance Monoid a => Applicative (Two a) where
  pure = Two mempty
  (Two a f) <*> (Two b x) = Two (a <> b) (f x)

-- Three

data Three a b c = Three a b c

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

instance (Monoid a, Monoid b) => Applicative (Three a b) where
  pure = Three mempty mempty
  (<*>) (Three a b f) (Three x y z) = Three (a <> x) (b <> y) (f z)

-- Three'

data Three' a b = Three' a b b

instance Functor (Three' a) where
  fmap f (Three a b c) = Three a (f b) (f c)

instance Monoid a => Applicative (Three' a) where
  pure a = Three mempty a a
  (<*>) (Three a f g) (Three x y z) = Three (a <> x) (f y) (g z)

-- Four

data Four a b c d = Four a b c d

instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

instance (Monoid a, Monoid b, Monoid c) => Applicative (Four a b c) where
  pure = Four mempty mempty mempty
  (<*>) (Four a b c f) (Four w x y z) = Four (a <> w) (b <> x) (c <> y) (f z)

-- Four'

data Four' a b = Four' a a a b

instance Functor (Four' a) where
  fmap f (Four' a b c d) = Four' a b c (f d)

instance Monoid a => Applicative (Four' a) where
  pure = Four' mempty mempty mempty
  (<*>) (Four' a b c f) (Four' w x y z) = Four' (a <> w) (b <> x) (c <> y) (f z)
