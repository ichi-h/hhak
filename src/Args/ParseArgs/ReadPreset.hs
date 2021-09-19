module Args.ParseArgs.ReadPreset
  ( readPreset
  ) where

import Args.HhakArgs (HhakArgs(..))
import Data.Either ()
import Control.Monad ()

readPreset :: ([String], [String]) -> Either String ([String], [String])
readPreset (front, back) = do
  -- overrideArgs (front, back) $ genPresetOptions $ readRC "~/.hhakrc"
  Right (front, back)
