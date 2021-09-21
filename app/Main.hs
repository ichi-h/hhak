module Main where

import System.Environment ( getArgs )
import System.Exit (exitWith, ExitCode (ExitFailure))
import Args.HhakArgs ( HhakArgs(..) )
import Util.ReadPassphrase ( readPassphrase )
import Args.HhakArgsGenerator ( genHhakArgs )
import Commands.CommandRunner ( runCommand )

main :: IO ()
main = do
  args <- getArgs

  case genHhakArgs args of
    Left err       -> do
      putStrLn err
      exitWith (ExitFailure 1)
    Right hhakArgs ->
      case command hhakArgs of
        "generate" -> do
          pass <- readPassphrase
          runCommand hhakArgs { passphrase = pass }
        _          -> do
          runCommand hhakArgs
