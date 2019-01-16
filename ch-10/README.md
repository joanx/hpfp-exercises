# Ch 10

## Notes:

* One initially non-obvious aspect of folding is that it happens in two stages, traversal and folding. Traversal is the stage in which the fold recurses over the spine. Folding refers to the evaluation or reduction of the folding function applied to the values. All folds recurse over the spine in the same direction; the difference between left folds and right folds is in the association, or parenthesization, of the folding function and, thus, which direction the folding or reduction proceeds

* foldr must force an initial cons cell in order to discriminate between the [] and the (x : xs) cases, so the first cons cell cannot be undefined

* foldl unconditionally evaluates the spine you can but doesn't necessarily evaluate all values

## Resources:

## Questions:

## Exercises:

### Understanding folds

1.  `foldr (*) 1 [1..5]` will return the same result as which of the following:
    a) `flip (*) 1 [1..5]`
    **b) `foldl (flip (*)) 1 [1..5]`**
    **c) `foldl (*) 1 [1..5]`**

2.  Write out the evaluation steps for `foldl (flip (*)) 1 [1..3]`

* `3 * foldl (flip (*)) 1 [1..2]`
* `3 * (2 * foldl (flip (*)) 1 [1])`
* `3 * (2 * (1 * 1)`
* `6`

3.  One difference between foldr and foldl is:
        a) foldr, but not foldl, traverses the spine of a list from right to left
        b) foldr, but not foldl, always forces the rest of the fold
        **c) foldr, but not foldl, associates to the right**
        d) foldr, but not foldl, is recursive

4.  Folds are catamorphisms, which means they are generally used to
    **a) reduce structure**
    b) expand structure
    c) render you catatonic
    d) generate infinite data structures

5.  The following are simple folds very similar to what you’ve already seen, but each has at least one error. Please fix them and test in your REPL:
    a) `foldr (++) ["woot", "WOOT", "woot"]` --> `foldr (++) "" ["woot", "WOOT", "woot"]`
    b) `foldr max [] "fear is the little death"` -> `foldr max ' ' "fear is the little death"`
    c) `foldr and True [False, True]` -> `foldr (&&) True [False, True]` (Why parens distinguishes btw reference to fn and application of fn?)
    d) This one is more subtle than the previous. Can it ever return a different answer? `foldr (||) True [False, True]` --> `foldr (||) False [False, True]`
    No. As written, can never return a different answer. (Is this the correct adjustment?)
    e) `foldl ((++) . show) "" [1..5]` -> `foldl (++) "" (map show [1..5])`
    f) `foldr const 'a' [1..5]` --> `foldr (flip const) 'a' [1..5]`
    I'm a little confused about this one. Does the type signature of `const` need to be consistent throughout the fold, i.e. String -> Int -> String? If not, I'd imagine the initial application would work and just return 1...
    g) `foldr const 0 "tacos"` --> `foldr (flip const) 0 "tacos"`
    h) `foldl (flip const) 0 "burritos"` --> `foldl const 0 "burritos"`
    foldl's first application will be applied against the starting value
    i) `foldl (flip const) 'z' [1..5]` --> `foldl flip const 'z' [1..5]`

    ### Exercises: Database Processing

See exercises.hs

## Chapter exercises

### Warm-up and review
