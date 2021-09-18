module Commands.CommandRunner
  ( runCommand
  ) where

import Args.HhakArgs (HhakArgs)

runCommand :: Either String HhakArgs -> Either String String
runCommand hhakArgs = Right "succsess"
