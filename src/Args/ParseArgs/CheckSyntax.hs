module Args.ParseArgs.CheckSyntax
  ( checkSyntax
  ) where

import Args.HhakArgs ()
import Util.StringOperation ( startWith, joinStr )
import Control.Monad ( when, unless )
import Data.Either ( fromLeft, fromRight, isLeft )

checkSyntax :: Either String ([String], [String]) -> Either String ([String], [String])
checkSyntax result = do
  when (isLeft result) $ Left $ fromLeft "" result

  let (front, back) = fromRight ([], []) result
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
