module Commands.CommandRunner
  ( runCommand
  ) where

import Args.HhakArgs ( HhakArgs(command, passphrase) )
import Commands.Generate.GenCmd ( genCmd, afterGen )
import Commands.Help.HelpCmd ( helpCmd, afterHelp )
import Commands.Version.VerCmd ( verCmd, afterVer )
import Util.ReadPassphrase ( readPassphrase )

runCommand :: HhakArgs -> IO ()
runCommand hhakArgs =
  case command hhakArgs of
    "help"     -> afterHelp helpCmd
    "version"  -> afterVer verCmd
    "generate" -> do
      pass <- readPassphrase
      afterGen $ genCmd hhakArgs { passphrase = pass }
    _          -> afterHelp helpCmd
