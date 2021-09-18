module Args.HhakArgs
  ( HhakArgs (..)
  , Options (..)
  , Algorithm (..)
  , defaultHhakArgs
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

defaultHhakArgs = do
  let options = Options { display = False
                        , force = False
                        , len = 20
                        , sym = "!\"#$%&‘()*+,-./:;<=>?@[\\]^_`{|}~"
                        , algo = Algo2b
                        , cost = 10
                        }

  HhakArgs { command = "help"
           , passphrase = ""
           , title = ""
           , preset = ""
           , options = options
           }

strToAlgo :: String -> Algorithm
strToAlgo "2b" = Algo2b
strToAlgo "2a" = Algo2a
strToAlgo "2y" = Algo2y
