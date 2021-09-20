module Commands.Generate.HashPassphrase
  ( hashPassphrase
  ) where

import Args.HhakArgs (HhakArgs)

hashPassphrase :: HhakArgs -> String
hashPassphrase hhakArgs = "hashed"
