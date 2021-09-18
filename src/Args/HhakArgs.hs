module Args.HhakArgs
  ( HhakArgs
  , Options
  , Algorithm
  , genHhakArgs
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

genHhakArgs :: [String] -> String -> Either String HhakArgs
genHhakArgs args passphrase = do
  addPassphrase passphrase $ overrideArgsByPreset $ perseArgs args

perseArgs :: [String] -> Either String HhakArgs
perseArgs args = do
  Right HhakArgs { command = "help"
           , passphrase = ""
           , title = ""
           , preset = ""
           , options = Options { display = False
                               , force = False
                               , len = 20
                               , sym = "!\"#$%&‘()*+,-./:;<=>?@[\\]^_`{|}~"
                               , algo = Algo2b
                               , cost = 10
                               }
           }

overrideArgsByPreset :: Either String HhakArgs -> Either String HhakArgs
overrideArgsByPreset hhakArgs = do
  hhakArgs

addPassphrase :: String -> Either String HhakArgs -> Either String HhakArgs
addPassphrase passphrase hhakArgs = do
  hhakArgs
