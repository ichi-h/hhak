module Commands.Generate.GenCmd
  ( genCmd
  , afterGen
  ) where

import Args.HhakArgs ( HhakArgs (passphrase) )
import Commands.Generate.HashPassphrase ( hashPassphrase )
import Commands.Generate.HashByBCrypt ( hashByBCrypt )
import Commands.Generate.ReplaceChars ( replaceChars )
import System.Process (readProcess)

genCmd :: HhakArgs -> String
genCmd hhakArgs = replaceChars hhakArgs $ hashByBCrypt hhakArgs $ hashPassphrase hhakArgs

afterGen :: String -> IO ()
afterGen result = do
  _ <- readProcess "echo foo" [] []
  putStrLn result
