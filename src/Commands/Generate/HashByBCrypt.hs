module Commands.Generate.HashByBCrypt
  ( hashByBCrypt
  ) where

import Args.HhakArgs (HhakArgs)

hashByBCrypt :: HhakArgs -> String -> String
hashByBCrypt hhakArgs hashedPass = "hashed"
