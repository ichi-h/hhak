module Args.HhakArgsGenerator
  ( genHhakArgs
  ) where

import Args.HhakArgs (HhakArgs)
import Args.ParseArgs (parseArgs)

genHhakArgs :: [String] -> String -> Either String HhakArgs
genHhakArgs args passphrase = do
  addPassphrase passphrase $ overrideArgsByPreset $ parseArgs args

overrideArgsByPreset :: Either String HhakArgs -> Either String HhakArgs
overrideArgsByPreset hhakArgs = do
  hhakArgs

addPassphrase :: String -> Either String HhakArgs -> Either String HhakArgs
addPassphrase passphrase hhakArgs = do
  hhakArgs
