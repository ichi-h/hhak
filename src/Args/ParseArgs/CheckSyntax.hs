module Args.ParseArgs.CheckSyntax
  ( checkSyntax
  ) where

import Args.HhakArgs ()
import Util.StringOperation ( startWith, joinStr )

checkSyntax :: Either String ([String], [String]) -> Either String ([String], [String])
checkSyntax result = do
  case result of
    Left msg -> Left msg
    Right _  -> hasInvalidAlgo $ hasUnknownOptions $ hasUnknownValues $ isEmpty result

isEmpty :: Either String ([String], [String]) -> Either String ([String], [String])
isEmpty result = do
  case result of
    Left msg            -> Left msg
    Right (front, back) ->
      if null (front ++ back) then
        Right ([], ["--help"])
      else
        Right (front, back)

hasUnknownValues :: Either String ([String], [String]) -> Either String ([String], [String])
hasUnknownValues result = do
  case result of
    Left msg            -> Left msg
    Right (front, back) ->
      if 2 < length front then
        Left $ "'" ++ joinStr ", " (drop 2 front) ++ "' is unknown argument."
      else
        Right (front, back)

hasUnknownOptions :: Either String ([String], [String]) -> Either String ([String], [String])
hasUnknownOptions result = do
  case result of
    Left msg            -> Left msg
    Right (front, back) ->
      if not isValid then
        Left $ "'" ++ opt ++ "' is unknown option."
      else
        Right (front, back)
      where (isValid, opt) = checkOperator back

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

hasInvalidAlgo :: Either String ([String], [String]) -> Either String ([String], [String])
hasInvalidAlgo result = do
  case result of
    Left msg            -> Left msg
    Right (front, back) ->
      if not isValid then
        Left $ "'" ++ opt ++ "' is invalid algorithm. It must be '2b', '2a' or '2y'"
      else
        Right (front, back)
      where (isValid, opt) = checkAlgo back

checkAlgo :: [String] -> (Bool, String)
checkAlgo [] = (True, "")
checkAlgo (x:xs) = do
  let start = startWith x
  if
    start "--algo" &&
    not ( start "--algo=2b" || start "--algo=2a" || start "--algo=2y")
  then (False, x)
  else checkAlgo xs
