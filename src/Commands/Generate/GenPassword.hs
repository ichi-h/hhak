module Commands.Generate.GenPassword
  ( genPassword
  ) where

import Args.HhakArgs ( HhakArgs(HhakArgs) )
import Commands.Generate.GenPassword.HashPassphrase ( hashPassphrase )
import Commands.Generate.GenPassword.HashByBCrypt ( hashByBCrypt )
import Commands.Generate.GenPassword.ReplaceChars ( replaceChars )

genPassword :: HhakArgs -> String
genPassword hhakArgs = replaceChars hhakArgs $ hashByBCrypt hhakArgs $ hashPassphrase hhakArgs
