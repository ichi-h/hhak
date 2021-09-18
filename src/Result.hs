module Result
  ( showResult
  ) where

showResult :: Either String String -> IO ()
showResult result = print "finish"
