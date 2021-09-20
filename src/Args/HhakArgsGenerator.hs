module Args.HhakArgsGenerator
  ( genHhakArgs
  ) where

import Args.HhakArgs ( HhakArgs )
import Args.ParseArgs.SepAtOptions ( sepAtOptions )
import Args.ParseArgs.ReadPreset ( readPreset )
import Args.ParseArgs.CheckSyntax ( checkSyntax )
import Args.ParseArgs.Parse ( parse )
import Data.Either ()

genHhakArgs :: [String] -> Either String HhakArgs
genHhakArgs args = parse $ checkSyntax $ readPreset $ sepAtOptions [] args
