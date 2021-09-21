module Main where

import Test.Hspec ( hspec )
import Args.HhakArgsGeneratorTest ( specGenHhakArgs )

main :: IO ()
main = hspec $ do
  specGenHhakArgs
