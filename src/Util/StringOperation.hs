module Util.StringOperation
  ( startWith
  , joinStr
  ) where

startWith :: String -> String -> Bool
startWith _ [] = False
startWith target searchStr = take (length searchStr) target == searchStr

joinStr :: String -> [String] -> String
joinStr _ [] = ""
joinStr sep [x] = x
joinStr sep (x:xs) = x ++ sep ++ joinStr sep xs
