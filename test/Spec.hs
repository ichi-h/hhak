module Main where

import Test.Hspec ( hspec )
import Args.HhakArgsGeneratorTest ( specGenHhakArgs )
import Commands.Generate.GenPasswordTest ( specGenPassword )

main :: IO ()
main = hspec $ do
  specGenHhakArgs
  specGenPassword
