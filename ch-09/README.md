# Week 6 Exercises

## Topics:

* Weak head normal form vs normal form
* Lists: spines and cons cells
* length will throw an error on a bottom value if part of the spine itself is bottom?? What does it mean for spine to be bottom
* Remember that an expression cannot be in normal form or weak head normal form if the outermost part of the expression isn’t a data constructor. It can’t be in normal form if any part of the expression is unevaluated

## Resources:

* https://stackoverflow.com/questions/6872898/haskell-what-is-weak-head-normal-form

## Questions:

* What's the value of the WHNF discussion?
* Can an expression be both in normal form and return bottom?

## Exercise: enumFromTo

See exercises.hs

## Exercises: Thy Fearful Symmetry

See exercises.hs

## Exercises: Bottom Madness

1.  `[x^y | x <- [1..5], y <- [2, undefined]]`
    ⊥. List comprehension forces evaluation of all x's and y's; x ^ undefined is undefined
2.  `take 1 $ [x^y | x <- [1..5], y <- [2, undefined]]`
    Evaluates. Never reaches undefined term
3.  `sum [1, undefined, 3]`
    ⊥. Sum iterates through all values and cannot sum undefined val
4.  `length [1, 2, undefined]`
    Evaluates. length only recurses along the spine
5.  `length $ [1, 2, 3] ++ undefined`
    ⊥. Length cannot evaluate when part of spine is bottom
6.  `take 1 $ filter even [1, 2, 3, undefined]`
    Evaluates. First even value is evaluated
7.  `take 1 $ filter even [1, 3, undefined]`
    ⊥. Unable to evaluate full list due to ⊥ value
8.  `take 1 $ filter odd [1, 3, undefined]`
    Evaluates. First odd value is evaluated
9.  `take 2 $ filter odd [1, 3, undefined]`
    Evaluates. First two odd values are evaluated
10. `take 3 $ filter odd [1, 3, undefined]`
    ⊥. Cannot eval full list

## Intermission: is it in normal form?

1.  [1, 2, 3, 4, 5]
    Normal form
2.  1 : 2 : 3 : 4 : \_
    WHNF - outermost expression is data constructor (:) but last element cannot be evaluated
3.  enumFromTo 1 10
    Neither - outermost part of expression is function application
4.  length [1, 2, 3, 4, 5]
    Neither - outermost part of expression is function application (length)
5.  sum (enumFromTo 1 10)
    Neither - outermost part of expression is function application (sum)
6.  ['a'..'m'] ++ ['n'..'z']
    Neither - outermost part of expression is function application (++)
7.  (\_, 'b')
    Weak head normal form

## Exercise: More bottoms

1.  Will the following expression return a value or be ⊥?

    ```
    take 1 $ map (+1) [undefined, 2, 3]
    ```

    Bottom. Cannot map (+1) over the first element in the list.

2.  Will the following expression return a value?

    ```
    take 1 $ map (+1) [1, undefined, 3]
    ```

    Yes. Due to lazy evaluation, (+1) is mapped over the first element only

3.  Will the following expression return a value?

    ```
    take 2 $ map (+1) [1, undefined, 3]
    ```

    No. Cannot evaluate (+1) of `undefined`

4.  What does the following mystery function do? What is its type? Describe it (to yourself or a loved one) in standard English and then test it out in the REPL to make sure you were correct.

    ```
    itIsMystery xs = map (\x -> elem x "aeiou") xs
    ```

    Takes a list and returns an array of bools identifying whether character was vowel

5.  What will be the result of the following functions:

    a)

    ```
    map (^2) [1..10]
    ```

    ```
    [1,4,9,16,25,36,49,64,81,100]
    ```

    b)

    ```
    map minimum [[1..10], [10..20], [20..30]]
    ```

    ```
    [1, 10, 20]
    ```

    c)

    ```
    map sum [[1..5], [1..5], [1..5]]
    ```

    ```
    [15, 15, 15]
    ```

6.  Back in the Functions chapter, you wrote a function called foldBool. That function exists in a module known as Data.Bool and is called bool. Write a function that does the same (or similar, if you wish) as the map (if-then-else) function you saw above but uses bool instead of the if-then-else syntax. Your first step should be bringing the bool function into scope by typing import Data.Bool at your Prelude prompt.

```
map (\x -> if x == 3 then (-x) else (x))
```

becomes

```
map (\x -> bool x (-x) (x == 3))
```

## Exercises: Filtering

1.  Given the above, how might we write a filter function that would give us all the multiples of 3 out of a list from 1-30?

```
filter (\x -> rem x 3 == 0) [1..30]
```

2.  Recalling what we learned about function composition, how could we compose the above function with the length function to tell us _how many_ multiples of 3 there are between 1 and 30?

```
length . filter (\x -> rem x 3 == 0) $ [1..30]
```

3.  Next we’re going to work on removing all articles (’the’, ’a’, and ’an’) from sentences.

```
noArticles = filter (\x -> notElem x ["the", "a", "an"]) . words
```

## Zipping Exercises

See exercises.hs

## Chapter Exercises

See exercises.hs
