module Commands.Generate.GenCmd
  ( genCmd
  ) where

import Args.HhakArgs ( HhakArgs (passphrase) )
import Commands.Generate.GenPassword ( genPassword )
import Commands.Generate.CopyClipboard ( copyClipboard )

genCmd :: HhakArgs -> Either String String
genCmd hhakArgs = copyClipboard hhakArgs $ genPassword hhakArgs
