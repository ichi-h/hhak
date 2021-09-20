module Commands.Generate.ReplaceChars
  ( replaceChars
  ) where

import Args.HhakArgs ( HhakArgs (options), Options (sym) )
import Util.StringOperation ( include, rmDup )

replaceChars :: HhakArgs -> String -> String
replaceChars hhakArgs hashed = do
  let symChars = genSymChars $ sym $ options hhakArgs
  randomReplace symChars $ removeSyms hashed

genSymChars :: String -> String
genSymChars syms =
  rmDup $ filter (\c -> not $ include [c] (['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9'])) syms

removeSyms :: String -> String
removeSyms password = "bar"

randomReplace :: String -> String -> String
randomReplace symChars password = "baz"
