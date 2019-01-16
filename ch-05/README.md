# Week 3 Exercises

## Ch 5 Exercises

### Questions
-- Function application left-associative vs. (->) operator right associative

### Exercises: Parametricity

2.

```
takeAnything :: a -> a -> a
takeAnything x y = x

takeAnything2 :: a -> a -> a
takeAnything2 x y = y
```

3.

```
returnSecondArg :: a -> b -> b
returnSecondArg x y = y
```

### Chapter Exercises

#### Multiple Choice
1. c\
2. a\
3. b\
4. c\

#### Determine the type

1.
a) (* 9) 6 :: Num a => a\
b) head [(0,"doge"),(1,"kitteh")] :: Num a => (a, [Char])\
c) head [(0 :: Integer ,"doge"),(1,"kitteh")] :: (Int, [Char])\
d) if False then True else False :: Bool\
e) length [1, 2, 3, 4, 5] :: Int\
f) (length [1, 2, 3, 4]) > (length "TACOCAT") :: Bool\

2.

```
x = 5
y = x + 5
w = y * 10
w :: Num a => a
```

3.

```
x = 5
y = x + 5
z y = y * 10
z :: Num a => a -> a
```

4.
```
x = 5
y = x + 5
f = 4 / y
f :: Fractional a => a
```


5.
```
x = "Julie"
y = " <3 "
z = "Haskell"
f = x ++ y ++ z
f :: [Char]
```
#### Does it compile?

1.
```
bigNum = (^) 5
wahoo = bigNum $ 10
```

2. No errors

3.
```
a = (+)
b = 5
c = a 10
d = c 200
```

4.
```
a = 12 + b
b = 10000 * c
c = 1
```
#### Type variable or specific type constructor?

2.
```f :: zed -> Zed -> Blah
fully polymorphic, concrete, concrete
```

3.
```
f :: Enum b => a -> b -> C
fully polymorphic, constrained polymorphic, concrete
```

4.
```
f :: f -> g -> C
fully polymorphic, fully polymorphic, concrete
```

#### Type-Kwon-Do

1.
```
f :: Int -> String
f = undefined

g :: String -> Char
g = undefined

h :: Int -> Char
h x = g (f x)
```

2.
```
data A
data B
data C
q :: A -> B
q = undefined
w :: B -> C
w = undefined
e :: A -> C
e = ???
```

3.
```
data X
data Y
data Z

xz :: X -> Z
xz = undefined

yz :: Y -> Z
yz = undefined

xform :: (X, Y) -> (Z, Z)
xform (x, y)= ((xz x), (yx y))
```

4.
```
munge :: (x -> y) -> (y -> (w, z)) -> x -> w
munge xToY yToWZ x = fst (yToWZ (xToY x))  
```
