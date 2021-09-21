module Commands.Version.VerCmd
  ( verCmd
  , afterVer
  ) where

verCmd :: String
verCmd = "hhak version 0.1.0"

afterVer :: String -> IO ()
afterVer = putStrLn
