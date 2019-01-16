# Questions

-We also imported from System.IO so that we could use hSetBuffering, stdout, and NoBuffering. That line of code is so that putStr isn’t buffered (deferred) and prints immediately

# Notes

* module names have to match filenames. Your compiler (not just Stack) will reject using a file that isn’t a Main module as the entry point to executing the program
* Executables are applications that the operating system will run directly, while software libraries are code arranged in a manner so that they can be reused by the compiler in the building of other libraries and programs.
* The do syntax specifically allows us to sequence monadic actions.
* return returns a value in IO
* If the final action of a do block is return (), that means there is no real value to return at the end of performing the IO actions
* It is not necessary, and considered bad style, to use do in single-line expressions. You will eventually learn to use >>= in single-line expressions instead of do
* `stack ghci` is the same as saying `stack ghci [package name]`. Tries to load library or executable stanzas

# Creating a project

1.  Create .cabal file to specify dependencies, modules / locations
2.  `stack init` to initialize stack file to describe snapshot of stackage
3.  `stack build` which installs dependencies and generates executable
4.  `stack ghci` if using library, `stack exec [executable]` if using executable

# Resources:

* https://docs.haskellstack.org/en/stable/stack_yaml_vs_cabal_package_file/
