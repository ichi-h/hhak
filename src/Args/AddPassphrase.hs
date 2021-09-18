module Args.AddPassphrase where

import Args.HhakArgs (HhakArgs(..), defaultHhakArgs)
import Data.Either
import Control.Monad

addPassphrase :: String -> Either String HhakArgs -> Either String HhakArgs
addPassphrase passphrase result = do
  when (isLeft result) $ Left $ fromLeft "" result

  let hhakArgs = fromRight defaultHhakArgs result
  Right (hhakArgs { passphrase = passphrase })
