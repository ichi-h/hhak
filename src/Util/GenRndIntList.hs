module Util.GenRndIntList
  ( genRndIntList
  ) where

import System.Random ( mkStdGen )
import System.Random.Stateful ( UniformRange(uniformRM), StatefulGen, runStateGen_ )
import Control.Monad ( replicateM )

genRndIntList :: Int -> Int -> Int -> [Int]
genRndIntList seed maxValue listLength = do
  let rdRange = uniformRM (0, maxValue) :: StatefulGen g m => g -> m Int
  let pureGen = mkStdGen seed
  runStateGen_ pureGen (replicateM listLength . rdRange)
