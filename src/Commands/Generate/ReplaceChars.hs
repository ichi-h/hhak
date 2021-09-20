module Commands.Generate.ReplaceChars
  ( replaceChars
  ) where

import Args.HhakArgs ( HhakArgs (options), Options (sym) )

replaceChars :: HhakArgs -> String -> String
replaceChars hhakArgs hashed = do
  let symChars = genSymChars $ sym $ options hhakArgs
  randomReplace symChars $ removeSyms hashed

genSymChars :: String -> String
genSymChars symOpt = "foo"

removeSyms :: String -> String
removeSyms password = "bar"

randomReplace :: String -> String -> String
randomReplace symChars password = "baz"
