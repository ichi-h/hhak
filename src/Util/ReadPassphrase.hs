module Util.ReadPassphrase
  ( readPassphrase
  ) where

import System.IO ( stdout, hFlush, hGetEcho, hSetEcho, stdin )
import Control.Exception ( bracket_ )

readPassphrase :: IO String 
readPassphrase = do
  putStr "[hhak] Passphrase: "
  hFlush stdout
  pass <- withEcho False getLine
  putChar '\n'
  return pass

withEcho :: Bool -> IO a -> IO a
withEcho echo action = do
  old <- hGetEcho stdin
  bracket_ (hSetEcho stdin echo) (hSetEcho stdin old) action
