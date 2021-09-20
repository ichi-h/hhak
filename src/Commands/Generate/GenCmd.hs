module Commands.Generate.GenCmd
  ( genCmd
  ) where

import Args.HhakArgs ( HhakArgs (passphrase) )
import Commands.Generate.HashPassphrase ( hashPassphrase )
import Commands.Generate.HashByBCrypt ( hashByBCrypt )
import Commands.Generate.ExchangeStr ( exchangeStr )
import Commands.Generate.CopyClipboard ( copyClipboard )

genCmd :: HhakArgs -> Either String String
genCmd hhakArgs = do
  copyClipboard hhakArgs $ exchangeStr hhakArgs $ hashByBCrypt hhakArgs $ hashPassphrase hhakArgs
