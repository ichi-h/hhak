module Util.StringOperation
  ( startWith
  , include
  , joinStr
  ) where

startWith :: String -> String -> Bool
startWith _ [] = False
startWith target searchStr = take (length searchStr) target == searchStr

include :: String -> String -> Bool
include _ [] = False
include target searchStr =
  if length searchStr < length target then
    False
  else if take (length target) searchStr == target then
    True
  else
    include target (tail searchStr)

joinStr :: String -> [String] -> String
joinStr _ [] = ""
joinStr sep [x] = x
joinStr sep (x:xs) = x ++ sep ++ joinStr sep xs
