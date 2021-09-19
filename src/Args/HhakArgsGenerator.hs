module Args.HhakArgsGenerator
  ( genHhakArgs
  ) where

import Args.HhakArgs (HhakArgs)
import Args.ParseArgs (parseArgs)
import Args.AddPassphrase (addPassphrase)

genHhakArgs :: [String] -> String -> Either String HhakArgs
genHhakArgs args passphrase = do
  addPassphrase passphrase $ parseArgs args
