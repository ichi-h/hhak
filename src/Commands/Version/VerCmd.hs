module Commands.Version.VerCmd
  ( verCmd
  ) where

import Args.HhakArgs (HhakArgs (command))

verCmd :: Either String String
verCmd = Right "hhak version 0.1.0"
