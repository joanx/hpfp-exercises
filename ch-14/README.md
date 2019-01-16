# Questions

# Notes

* arbitrary is a value of type Gen
* We use the Arbitrary typeclass in order to provide a generator for sample, e.g. `sample (arbitrary :: Gen Int)`
* The arbitrary typeclass is unprincipled because it has no laws and nothing specific it’s supposed to do. It’s just a convenient way of plucking a canonical generator for Gen a out of thin air without having to know where it comes from
* Reminder: return doesn’t do a whole lot except return a value inside of a monad
  -- `return :: Monad m => a -> m a`
  -- `return :: a -> Gen a`
* `choose :: System.Random.Random a => (a, a) -> Gen a`
* `elements :: [a] -> Gen a`
* Gen values are generators of random values that QuickCheck uses to get test values from.
* `elements` takes a list of some type and chooses a `Gen` value from the values in that list
* `stack test .` is an alias for `stack build --test .` or `stack ghci [project-name]:tests`.
* Use `stack build --test [project-name]:tests` to run a particular test
