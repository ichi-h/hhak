module Commands.CommandRunner
  ( runCommand
  ) where

import Args.HhakArgs (HhakArgs (command))
import Commands.Generate.GenCmd (genCmd)
import Commands.Help.HelpCmd (helpCmd)
import Commands.Version.VerCmd (verCmd)

runCommand :: Either String HhakArgs -> Either String String
runCommand result = do
  case result of
    Left msg -> Left msg
    Right hhakArgs -> case command hhakArgs of
      "help"     -> helpCmd
      "version"  -> verCmd
      "generate" -> genCmd hhakArgs
      _          -> helpCmd hhakArgs
