module Commands.Generate.ReplaceChars
  ( replaceChars
  ) where

import Args.HhakArgs ( HhakArgs (options), Options (sym) )
import Util.StringOperation ( include, rmDup )
import Util.DJB2Hash (djd2hash)

import System.Random ( mkStdGen )
import System.Random.Stateful ( UniformRange(uniformRM), StatefulGen, runStateGen_ )
import Control.Monad ( replicateM )

replaceChars :: HhakArgs -> String -> String
replaceChars hhakArgs hashed = do
  let symChars = genSymChars $ sym $ options hhakArgs
  randomReplace symChars $ removeSyms hashed

genSymChars :: String -> String
genSymChars syms =
  rmDup $ filter (\c -> not $ include [c] (['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9'])) syms

removeSyms :: String -> String
removeSyms password = padding password $ remove password

remove :: String -> String
remove = filter (\c -> include [c] (['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']))

padding :: String -> String -> String
padding password removed = do
  let chars = ['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']
  let rdCharM = uniformRM (0, Prelude.length chars - 1) :: StatefulGen g m => g -> m Int
  let pureGen = mkStdGen $ djd2hash password
  let randomStr = Prelude.map (chars !!) $ runStateGen_ pureGen (replicateM (length password - length removed) . rdCharM)
  removed ++ randomStr

randomReplace :: String -> String -> String
randomReplace symChars password = "baz"
