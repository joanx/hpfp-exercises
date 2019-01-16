# Ch 8 Exercises

## Intermission: Exercise

* applyTimes 5 (+1) 5
* (+1) (applyTimes 4 (+1) 5)
* (+1) ((+1) applyTimes 3 (+1) 5)
* (+1) ((+1) ((+1) applyTimes 2 (+1) 5))
* (+1) ((+1) ((+1) ((+1) applyTimes 1 (+1) 5)))
* (+1) ((+1) ((+1) ((+1) ((+1) applyTimes 0 (+1) 5))))
* (+1) ((+1) ((+1) ((+1) ((+1) 5))))
* (+1) ((+1) ((+1) ((+1) 6)))
* (+1) ((+1) ((+1) 7))
* (+1) ((+1) 8)
* (+1) 9
* 10

## Chapter Exercises

### Review of types

1.  What is the type of [[True, False], [True, True], [False, True]]?
    d) [[Bool]]
2.  Which of the following has the same type as [[True, False], [True, True], [False, True]]?
    b) [[3 == 3], [6 > 5], [3 < 4]]
3.  For the following function
    func :: [a] -> [a] -> [a]
    func x y = x ++ y
    which of the following is true?
    a) x and y must be of the same type
    b) x and y must both be lists
    c) if x is a String then y must be a String
    d) all of the above <--- that one
4.  For the func code above, which is a valid application of func to both of its arguments?
    b) func "Hello" "World"

## Reviewing currying

Given the following definitions, tell us what value results from further applications.
cattyConny :: String -> String -> String
cattyConny x y = x ++ " mrow " ++ y
-- fill in the types
flippy :: String -> String -> String
flippy = flip cattyConny

appedCatty :: String -> String
appedCatty = cattyConny "woops"

frappe :: String -> String
frappe = flippy "haha"

1.  What is the value of appedCatty "woohoo!" ? Try to determine the
    answer for yourself, then test in the REPL.
    "woops mrow woohoo!"
2.  frappe "1"
    "1 mrow haha"
3.  frappe (appedCatty "2")
    frappe ("woops mrow 2")
    flippy "haha" ("woops mrow 2")
    "woops mrow 2 mrow haha"
4.  appedCatty (frappe "blue")
    appedCatty (flippy "haha" "blue")
    appedCatty ("blue mrow haha")
    cattyConny "woops" "blue mrow haha"
    "woops mrow blue mrow haha"
5.  cattyConny (frappe "pink") (cattyConny "green" (appedCatty "blue"))
    cattyConny (flippy "haha" "pink") (cattyConny "green" (cattyConny "woops" "blue"))
    cattyConny (flippy "haha" "pink") (cattyConny "green" "woops mrow blue")
    cattyConny (flippy "haha" "pink") "green mrow woops mrow blue"
    cattyConny ("pink mrow haha") "green mrow woops mrow blue"
    "pink mrow haha mrow green mrow woops mrow blue"
6.  cattyConny (flippy "Pugs" "are") "awesome"
    cattyConny ("are mrow Pugs") "awesome"
    "are mrow Pugs mrow awesome"

## Recursion

1.  Write out the steps for reducing dividedBy 15 2 to its final answer according to the Haskell code.
    dividedBy 15 2 =
    go 15 2 0
    go 13 2 1
    go 11 2 2
    go 9 2 3
    go 7 2 4
    go 5 2 5
    go 3 2 6
    go 1 2 7
    (7, 1)
2.  See .hs file
3.  See .hs file
