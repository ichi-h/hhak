module Result
  ( showResult
  ) where

showResult :: Either String String -> IO ()
showResult result = do
  case result of
    Left  s -> putStrLn s
    Right s -> putStrLn s
