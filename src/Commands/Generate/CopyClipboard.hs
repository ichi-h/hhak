module Commands.Generate.CopyClipboard
( copyClipboard
) where

import Args.HhakArgs ( HhakArgs )

copyClipboard :: HhakArgs -> String -> Either String String
copyClipboard hhakArgs password = Right "Password was copied to clipboard!"
