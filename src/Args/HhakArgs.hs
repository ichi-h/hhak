module Args.HhakArgs
  ( HhakArgs (..)
  , Options (..)
  , Algorithm (..)
  , strToAlgo
  ) where

data HhakArgs = HhakArgs { command :: String
                         , passphrase :: String
                         , title :: String
                         , preset :: String
                         , options :: Options
                         }

data Options = Options { display :: Bool
                       , force :: Bool
                       , len :: Int
                       , sym :: String
                       , algo :: Algorithm
                       , cost :: Int
                       }

data Algorithm =  Algo2b | Algo2a | Algo2y

strToAlgo :: String -> Algorithm
strToAlgo "2b" = Algo2b
strToAlgo "2a" = Algo2a
strToAlgo "2y" = Algo2y
