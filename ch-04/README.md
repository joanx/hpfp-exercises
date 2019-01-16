# Week 3 Exercises

## Chapter 4 Exercises

1. [a] -> Integer

2.
a) 5\
b) 3\
c) 2\
d) 5\

3. 6 / length [1,2,3] fails
The input to (/) is a Fractional value, whereas the the return value of `length` is an Int. Fractional values are not integers.

4. Use `div` instead, which handles integer values

5. Bool

6. Int -> Bool

7.
length allAwesome == 2 reduces to True\
length [1, 'a', 3, 'b'] reduces to 4\
length allAwesome + length awesome reduces to 5\
(8 == 8) && ('b' < 'a') reduces to True && False which reduces to False\
(8 == 8) && 9 does not reduce (True && 9). 9 is not a boolean value\
