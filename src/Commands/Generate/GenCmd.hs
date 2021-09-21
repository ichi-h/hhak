module Commands.Generate.GenCmd
  ( genCmd
  ) where

import Args.HhakArgs ( HhakArgs (passphrase) )
import Commands.Generate.HashPassphrase ( hashPassphrase )
import Commands.Generate.HashByBCrypt ( hashByBCrypt )
import Commands.Generate.ReplaceChars ( replaceChars )

genCmd :: HhakArgs -> Either String String
genCmd hhakArgs = Right $ replaceChars hhakArgs $ hashByBCrypt hhakArgs $ hashPassphrase hhakArgs
