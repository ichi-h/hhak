module Commands.CommandRunner
  ( runCommand
  ) where

import Args.HhakArgs ( HhakArgs(command) )
import Commands.Generate.GenCmd ( genCmd, afterGen )
import Commands.Help.HelpCmd ( helpCmd, afterHelp )
import Commands.Version.VerCmd ( verCmd, afterVer )

runCommand :: HhakArgs -> IO ()
runCommand hhakArgs =
  case command hhakArgs of
    "help"     -> afterHelp helpCmd
    "version"  -> afterVer verCmd
    "generate" -> afterGen $ genCmd hhakArgs
    _          -> afterHelp helpCmd
