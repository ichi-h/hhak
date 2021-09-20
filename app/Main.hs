module Main where

import System.Environment ( getArgs )
import Args.HhakArgs ( HhakArgs(..) )
import ReadPassphrase ( readPassphrase )
import Args.HhakArgsGenerator ( genHhakArgs )
import Commands.CommandRunner ( runCommand )
import Result ( showResult )

main :: IO ()
main = do
  args <- getArgs

  case genHhakArgs args of
    Left err       -> showResult $ Left err
    Right hhakArgs ->
      case command hhakArgs of
        "generate" -> do
          pass <- readPassphrase
          runAndShow $ Right hhakArgs { passphrase = pass }
        _          -> do
          runAndShow $ Right hhakArgs

runAndShow :: Either String HhakArgs -> IO ()
runAndShow result = showResult $ runCommand result
