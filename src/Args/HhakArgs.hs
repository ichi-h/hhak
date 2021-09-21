module Args.HhakArgs
  ( HhakArgs (..)
  , Options (..)
  , Algorithm (..)
  , defaultHhakArgs
  , strToAlgo
  , algoToStr
  ) where
import GHC.Show (Show)

data HhakArgs = HhakArgs { command :: String
                         , passphrase :: String
                         , title :: String
                         , preset :: String
                         , options :: Options
                         } deriving (Show)

data Options = Options { display :: Bool
                       , force :: Bool
                       , len :: Int
                       , sym :: String
                       , algo :: Algorithm
                       , cost :: Int
                       } deriving (Show)

data Algorithm =  Algo2b | Algo2a | Algo2y deriving (Show)

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
strToAlgo "2a" = Algo2a
strToAlgo "2y" = Algo2y
strToAlgo _    = Algo2b

algoToStr :: Algorithm -> String
algoToStr Algo2b = "2b"
algoToStr Algo2a = "2a"
algoToStr Algo2y = "2y"
