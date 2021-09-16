module Main where

import System.Environment (getArgs)

main = do
  args <- getArgs
  let str_num = head args
  let num = read str_num :: Int
  print (num > 100)
