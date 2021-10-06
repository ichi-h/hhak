module Args.ParseArgs.CheckSyntax
  ( checkSyntax
  ) where

import Args.HhakArgs ()
import Util.StringOperation ( startWith, joinStr, include )

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
      where (isValid, opt) = checkOperator front back

checkOperator :: [String] -> [String] -> (Bool, String)
checkOperator _ [] = (True, "")
checkOperator front (x:xs) = do
  let start = startWith x
  case length (front ++ x:xs) of
    1 ->
      if
        (x == "-h"         ||
         x == "--help"     ||
         x == "-v"         ||
         x == "--version") &&
         not (not (start "--") && include "d" x ||
              not (start "--") && include "f" x ||
              x == "--display" ||
              x == "--force"   ||
              start "--len="   ||
              start "--sym="   ||
              start "--algo="  ||
              start "--cost=")
      then checkOperator front xs
      else (False, x)
    _ ->
      if
        not (x == "-h"         ||
             x == "--help"     ||
             x == "-v"         ||
             x == "--version") &&
        (not (start "--") && include "d" x ||
         not (start "--") && include "f" x ||
         x ==  "--display"  ||
         x ==  "--force"    ||
         start "--len="     ||
         start "--sym="     ||
         start "--algo="    ||
         start "--cost=")
      then checkOperator front xs
      else (False, x)

hasInvalidAlgo :: Either String ([String], [String]) -> Either String ([String], [String])
hasInvalidAlgo result = do
  case result of
    Left msg            -> Left msg
    Right (front, back) ->
      if not isValid then
        Left $ "'" ++ drop (length "--algo=") opt ++ "' is invalid algorithm. It must be '2b', '2a' or '2y'."
      else
        Right (front, back)
      where (isValid, opt) = checkAlgo back

checkAlgo :: [String] -> (Bool, String)
checkAlgo [] = (True, "")
checkAlgo (x:xs) = do
  let start = startWith x
  if not (start "--algo") || (start "--algo=2b" || start "--algo=2a" || start "--algo=2y")
    then checkAlgo xs
    else (False, x)
