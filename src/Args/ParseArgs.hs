module Args.ParseArgs
  ( parseArgs
  ) where

import Args.HhakArgs
import Util.StringOperation
import GHC.Base (when)
import Control.Monad
import Data.Either

parseArgs :: [String] -> Either String HhakArgs
parseArgs args = parse $ checkSyntax $ sepAtOptions [] args

sepAtOptions :: [String] -> [String] -> ([String], [String])
sepAtOptions acc [] = (acc, [])
sepAtOptions acc (arg:args) =
    if head arg == '-' then
      (acc, args)
    else
      sepAtOptions (acc++[arg]) args

checkSyntax :: ([String], [String]) -> Either String ([String], [String])
checkSyntax (front, back) = do
  when (2 < length front) $ Left $ "'" ++ joinStr ", " (drop 2 front) ++ "' is unknown argument."

  let (isValid, opt) = checkOperator back
  unless isValid $ Left $ "'" ++ opt ++ "' is invalid option."

  let (isValid, opt) = checkAlgo back
  unless isValid $ Left $ "'" ++ opt ++ "' is invalid algorithm. It must be '2b', '2a' or '2y'"

  Right (front, back)

checkOperator :: [String] -> (Bool, String)
checkOperator [] = (True, "")
checkOperator (x:xs) = do
  let start = startWith x
  if
    start "-h" ||
    start "--help" ||
    start "-v" ||
    start "--version" ||
    start "--display" ||
    start "-f" ||
    start "--force" ||
    start "--len=" ||
    start "--sym=" ||
    start "--algo" ||
    start "--cost"
  then (False, x)
  else checkOperator xs

checkAlgo :: [String] -> (Bool, String)
checkAlgo [] = (True, "")
checkAlgo (x:xs) = do
  let start = startWith x
  if
    start "--algo" &&
    not ( start "--algo=2b" || start "--algo=2a" || start "--algo=2y")
  then (False, x)
  else checkAlgo xs

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
    options { len = read (drop (length "--len=") arg) :: Int }
  else if start "--sym=" then
    options { sym = drop (length "--sym=") arg }
  else if start "--algo=" then
    options { algo = strToAlgo $ drop (length "--algo=") arg }
  else if start "--cost=" then
    options { cost = read (drop (length "--cost=") arg) :: Int }
  else
    options
