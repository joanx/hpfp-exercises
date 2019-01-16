module Main (main) where

import Hangman (main)
-- Chris, I added this since it seemed like the executable
-- needed a Main.hs, but I'm wondering why I couldn't just
-- have the executable point at src/Hangman.hs
-- It also seemed like having src/Main.hs and tests/Main.hs was problematic
-- since module names conflicted
