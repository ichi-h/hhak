module Main where

import System.Environment ( getArgs )
import Args.HhakArgs ( HhakArgs(..) )
import Util.ReadPassphrase ( readPassphrase )
import Args.HhakArgsGenerator ( genHhakArgs )
import Commands.CommandRunner ( runCommand )
import AfterAll ( afterAll )

main :: IO ()
main = do
  args <- getArgs

  case genHhakArgs args of
    Left err       -> afterAll $ Left err
    Right hhakArgs ->
      case command hhakArgs of
        "generate" -> do
          pass <- readPassphrase
          run $ Right hhakArgs { passphrase = pass }
        _          -> do
          run $ Right hhakArgs

run :: Either String HhakArgs -> IO ()
run result = afterAll $ runCommand result
