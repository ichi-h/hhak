module AfterAll
  ( afterAll
  ) where

afterAll :: Either String String -> IO ()
afterAll result = do
  case result of
    Left  s -> putStrLn s
    Right s -> putStrLn s
