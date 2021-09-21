module Args.ParseArgs.Parse
  ( parse
  ) where

import Args.HhakArgs ( Algorithm(Algo2b), Options(..), HhakArgs(..), strToAlgo )
import Util.StringOperation ( startWith )

parse :: Either String ([String], [String]) -> Either String HhakArgs
parse result = do
  case result of
    Left msg            -> Left msg
    Right (front, back) ->
      Right HhakArgs { command = getCmd (front, back)
                     , passphrase = ""
                     , title = getTitle front
                     , preset = if length front == 2 then last front else ""
                     , options = argsToOptions back
                     }

getTitle :: [String] -> String
getTitle front = if null front then "" else head front

getCmd :: ([String], [String]) -> String
getCmd (front, back) =
  case length $ front ++ back of
    0 -> "help"
    1 ->
      case opt of
        "-v"        -> "version"
        "--version" -> "version"
        "-h"        -> "help"
        "--help"    -> "help"
        _           -> "generate"
        where opt = if null back then "" else head back
    _ -> "generate"

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

  case arg of
    _ | start "-d" || start "--display" -> options { display = True }
      | start "-f" || start "--force"   -> options { force = True }
      | start "--len="  -> options { len = read $ drop (length "--len=") arg :: Int }
      | start "--sym="  -> options { sym = drop (length "--sym=") arg }
      | start "--algo=" -> options { algo = strToAlgo $ drop (length "--algo=") arg }
      | start "--cost=" -> options { cost = read $ drop (length "--cost=") arg :: Int }
      | otherwise       -> options
