module Main where

import Test.Hspec ( hspec )
import Args.HhakArgsGeneratorTest ( specGenHhakArgs )
import Commands.Generate.GenCmdTest ( specGenCmd )

main :: IO ()
main = hspec $ do
  specGenHhakArgs
  specGenCmd
