module Args.ParseArgs
  ( parseArgs
  ) where

import Args.HhakArgs ( HhakArgs )
import Args.ParseArgs.SepAtOptions ( sepAtOptions )
import Args.ParseArgs.ReadPreset ( readPreset )
import Args.ParseArgs.CheckSyntax ( checkSyntax )
import Args.ParseArgs.Parse ( parse )
import Data.Either ()

parseArgs :: [String] -> Either String HhakArgs
parseArgs args = parse $ checkSyntax $ readPreset $ sepAtOptions [] args
