module Util.StringOperation
  ( startWith
  , include
  , rmDup
  , joinStr
  ) where

startWith :: String -> String -> Bool
startWith _ [] = False
startWith target searchStr = take (length searchStr) target == searchStr

include :: (Eq a) => [a] -> [a] -> Bool
include _ [] = False
include target searchStr
  | length searchStr < length target         = False
  | take (length target) searchStr == target = True
  | otherwise                                = include target (tail searchStr)

rmDup :: (Eq a) => [a] -> [a]
rmDup = foldl (\acc item -> if not $ include [item] acc then acc ++ [item] else acc) []

joinStr :: String -> [String] -> String
joinStr _ [] = ""
joinStr sep [x] = x
joinStr sep (x:xs) = x ++ sep ++ joinStr sep xs
