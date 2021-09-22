module Commands.Generate.GenCmd
  ( GenResult (..)
  , genCmd
  , afterGen
  ) where

import Args.HhakArgs ( HhakArgs (passphrase, options), Options (display) )
import Commands.Generate.HashPassphrase ( hashPassphrase )
import Commands.Generate.HashByBCrypt ( hashByBCrypt )
import Commands.Generate.ReplaceChars ( replaceChars )
import Util.StringOperation ( include )

import System.Exit ( exitWith, ExitCode (ExitFailure) )
import System.Process ( callCommand )
import System.Info ( os )
import Control.Exception ( catch, SomeException (SomeException) )
import Text.Show (Show)

data GenResult = GenResult { password :: String
                           , isDisplay :: Bool
                           } deriving (Show)

genCmd :: HhakArgs -> GenResult
genCmd hhakArgs = do
  let password = replaceChars hhakArgs $ hashByBCrypt hhakArgs $ hashPassphrase hhakArgs
  GenResult { password = password
            , isDisplay = display $ options hhakArgs
            }

afterGen :: GenResult -> IO ()
afterGen result = do
  let pass = foldl (\acc c -> if c == '"' then acc ++ "\\\"" else acc ++ [c]) [] (password result)

  catch (do
    case os of
      "mingw32" -> callCommand $ "echo \"" ++ pass ++ "\" | clip.exe"
      "linux"   -> callCommand $ "echo \"" ++ pass ++ "\" | xclip -selection c"
      "darwin"  -> callCommand $ "echo \"" ++ pass ++ "\" | pbcopy"
      _ -> do
        putStrLn "Sorry, your platform is not yet supported."
        exitWith (ExitFailure 1)
    ) $ \(SomeException e) -> do
      putStrLn $ hidePass [] pass $ show e
      exitWith (ExitFailure 1)

  putStrLn "Password was copied to clipboard!"
  if isDisplay result then
    putStrLn $ "Password: " ++ password result
  else
    putStr ""

hidePass :: String -> String -> String -> String
hidePass _ [] searchStr = searchStr
hidePass acc _ [] = acc
hidePass acc (x:xs) searchStr = do
  let len = length (x:xs)
  let trimed = take len searchStr
  if trimed == (x:xs) then
    acc ++ replicate 4 '*' ++ drop len searchStr
  else
    hidePass (acc ++ [head searchStr]) (x:xs) (tail searchStr)
