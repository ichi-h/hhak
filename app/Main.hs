module Main where

import System.Environment (getArgs)
import ReadPassphrase (readPassphrase)
import Args.HhakArgs (genHhakArgs)
import Commands.CommandRunner (runCommand)
import Result (showResult)

main :: IO ()
main = do
  args <- getArgs
  pass <- readPassphrase

  showResult $ runCommand $ genHhakArgs args pass
