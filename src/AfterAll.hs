module AfterAll
  ( afterAll
  ) where

import System.Exit (exitWith, ExitCode (ExitFailure))

afterAll :: Either String String -> IO ()
afterAll result = do
  case result of
    Left err -> do
      putStrLn err
      exitWith (ExitFailure 1)
    Right s  -> putStrLn s
