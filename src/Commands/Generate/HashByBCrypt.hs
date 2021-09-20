module Commands.Generate.HashByBCrypt
  ( hashByBCrypt
  ) where

import Args.HhakArgs ( HhakArgs, Algorithm, algoToStr )
import Util.StringOperation ( joinStr )
import Data.ByteString ( ByteString )
import Data.ByteString.UTF8 as BSU ( fromString )
import System.Random ( mkStdGen )
import System.Random.Stateful ( UniformRange(uniformRM), StatefulGen, runStateGen_ )
import Control.Monad ( replicateM )

hashByBCrypt :: HhakArgs -> String -> String
hashByBCrypt hhakArgs hashedPass = "hashed"

genRealSalt :: Int -> String
genRealSalt seed = do
  let c = ['a'..'z'] ++ ['A'..'Z'] ++ ['.', '/']
  let rdCharM = uniformRM (0, Prelude.length c - 1) :: StatefulGen g m => g -> m Int
  let pureGen = mkStdGen seed
  Prelude.map (c !!) $ runStateGen_ pureGen (replicateM 22 . rdCharM)
