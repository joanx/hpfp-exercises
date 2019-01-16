# Questions

* Intermediate exercise - is `mempty` for Optional a `Only mempty a` or `Nada`?
* Confused by example on p 593: `\ (<>) a b c -> a <> (b <> c) == (a <> b) <> c` . Is the first arg bound to `mappend` while the other args remain unbound? Or is that just a generic syntax for `f`? What do they mean by "You can bind infix names for function arguments?"
* In `monoidLeftIdentity a = (mempty <> a) == a` - is `mempty` an inferred value?
* How to create general stack.yaml for all projects?

# Notes

* Integers form a monoid under summation and multiplication. We can similarly say that lists form a monoid under concatenation.
* The main differences are that using newtype constrains the datatype to having a single unary data constructor and newtype guarantees no additional runtime overhead in “wrapping” the original type. That is, the runtime representation of newtype and what it wraps are always identical — no additional “boxing up” of the data as is necessary for typical products and sums.
* In summary, why you might use newtype

1.  Signal intent: using newtype makes it clear that you only intend for it to be a wrapper for the underlying type. The newtype cannot eventually grow into a more complicated sum or product type, while a normal datatype can.
2.  Improve type safety: avoid mixing up many values of the same representation, such as Text or Integer.
3.  Add different typeclass instances to a type that is otherwise unchanged representationally, such as with Sum and Product.

# Exercises
