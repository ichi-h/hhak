module Commands.Generate.GenCmd
  ( genCmd
  ) where

import Args.HhakArgs (HhakArgs (command))

genCmd :: HhakArgs -> Either String String
