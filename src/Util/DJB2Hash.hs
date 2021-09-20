module Util.DJB2Hash
  ( djd2hash
  ) where

djd2hash :: String -> Int
djd2hash = foldl (\hash c -> 33 * hash + fromEnum c) 5381
