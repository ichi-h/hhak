module Commands.Generate.HashByBCrypt
  ( hashByBCrypt
  ) where

import Args.HhakArgs ( HhakArgs (options), Options (cost, len) )
import Util.DJB2Hash ( djd2hash )

import Crypto.KDF.BCrypt ( bcrypt )
import Data.ByteString.UTF8 as BSU ( fromString, toString )
import System.Random ( mkStdGen )
import System.Random.Stateful ( UniformRange(uniformRM), StatefulGen, runStateGen_ )
import Control.Monad ( replicateM )

hashByBCrypt :: HhakArgs -> String -> String
hashByBCrypt hhakArgs hashedPass = recGenHash hhakArgs hashedPass "" 0

recGenHash :: HhakArgs -> String -> String -> Int -> String
recGenHash hhakArgs hashedPass hash i = do
  case passLen of
    _ | passLen <= length hash -> take passLen hash
      | otherwise              -> do
          let realHash = genBCryptHash (cost $ options hhakArgs) hashedPass ++ show i
          recGenHash hhakArgs hashedPass (hash ++ realHash) (i + 1)
    where passLen = len $ options hhakArgs

genBCryptHash :: Int -> String -> String
genBCryptHash bCost hashedPass = do
  let bytePass = BSU.fromString hashedPass
  let realSalt = BSU.fromString $ genRealSalt $ djd2hash hashedPass
  take 31 $ reverse $ BSU.toString $ bcrypt bCost realSalt bytePass

genRealSalt :: Int -> String
genRealSalt seed = do
  let c = ['a'..'z'] ++ ['A'..'Z'] ++ ['.', '/']
  let rdCharM = uniformRM (0, Prelude.length c - 1) :: StatefulGen g m => g -> m Int
  let pureGen = mkStdGen seed
  Prelude.map (c !!) $ runStateGen_ pureGen (replicateM 16 . rdCharM)
