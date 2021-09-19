module Args.AddPassphrase where

import Args.HhakArgs (HhakArgs(..), defaultHhakArgs)

addPassphrase :: String -> Either String HhakArgs -> Either String HhakArgs
addPassphrase passphrase result = do
  case result of
    Left msg       -> Left msg
    Right hhakArgs -> Right $ hhakArgs { passphrase = passphrase }
