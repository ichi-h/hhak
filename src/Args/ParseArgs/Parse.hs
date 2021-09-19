module Args.ParseArgs.Parse
  ( parse
  ) where

import Args.HhakArgs ( Algorithm(Algo2b), Options(..), HhakArgs(..), strToAlgo )
import Util.StringOperation ( startWith )
import Control.Monad ( when )
import Data.Either ( fromLeft, fromRight, isLeft )

parse :: Either String ([String], [String]) -> Either String HhakArgs
parse result = do
  when (isLeft result) $ Left $ fromLeft "" result

  let (front, back) = fromRight ([], []) result
  Right HhakArgs { command = getCmd (front, back)
                 , passphrase = ""
                 , title = head front
                 , preset = if length front == 2 then last front else ""
                 , options = argsToOptions back
                 }

getCmd :: ([String], [String]) -> String
getCmd (front, back) =
  case length $ front ++ back of
    0 -> "help"
    1 ->
      case head back of
        "-v"        -> "version"
        "--version" -> "version"
        "-h"        -> "help"
        "--help"    -> "help"
        _           -> "cmd"
    _ -> "cmd"

argsToOptions :: [String] -> Options
argsToOptions args = do
  let options = Options { display = False
                        , force = False
                        , len = 20
                        , sym = "!\"#$%&‘()*+,-./:;<=>?@[\\]^_`{|}~"
                        , algo = Algo2b
                        , cost = 10
                        }
  foldl updateOption options args

updateOption :: Options -> String -> Options
updateOption options arg = do
  let start = startWith arg

  if start "-d" || start "--display" then
    options { display = True }
  else if start "-f" || start "--force" then
    options { force = True }
  else if start "--len=" then
    options { len = read $ drop (length "--len=") arg :: Int }
  else if start "--sym=" then
    options { sym = drop (length "--sym=") arg }
  else if start "--algo=" then
    options { algo = strToAlgo $ drop (length "--algo=") arg }
  else if start "--cost=" then
    options { cost = read $ drop (length "--cost=") arg :: Int }
  else
    options
