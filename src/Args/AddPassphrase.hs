module Args.AddPassphrase where

import Args.HhakArgs (HhakArgs(..), defaultHhakArgs)
import Data.Either ( fromLeft, fromRight, isLeft )
import Control.Monad ( when )

addPassphrase :: String -> Either String HhakArgs -> Either String HhakArgs
addPassphrase passphrase result = do
  when (isLeft result) $ Left $ fromLeft "" result

  let hhakArgs = fromRight defaultHhakArgs result
  Right (hhakArgs { passphrase = passphrase })
