module Commands.Generate.ExchangeStr
  ( exchangeStr
  ) where

import Args.HhakArgs ( HhakArgs (options), Options (sym) )

exchangeStr :: HhakArgs -> String -> String
exchangeStr hhakArgs hashed = do
  let symChars = genSymChars $ sym $ options hhakArgs
  randomReplace symChars $ removeSyms hashed

genSymChars :: String -> String
genSymChars symOpt = "foo"

removeSyms :: String -> String
removeSyms password = "bar"

randomReplace :: String -> String -> String
randomReplace symChars password = "baz"
