module Commands.Generate.ReplaceChars
  ( replaceChars
  ) where

import Args.HhakArgs ( HhakArgs (options), Options (sym) )
import Util.StringOperation ( include, rmDup )
import Util.DJB2Hash ( djd2hash )
import Util.GenRndIntList ( genRndIntList )
import Data.List (sort)

replaceChars :: HhakArgs -> String -> String
replaceChars hhakArgs hashed = do
  let symChars = genSymChars $ sym $ options hhakArgs
  randomReplace symChars $ removeSyms hashed

genSymChars :: String -> String
genSymChars syms =
  rmDup $ filter (\c -> not $ include [c] (['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9'])) syms

removeSyms :: String -> String
removeSyms password = padding password $ remove password

remove :: String -> String
remove = filter (\c -> include [c] (['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']))

padding :: String -> String -> String
padding password removed = do
  let
    chars = ['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']
    seed = djd2hash password - 1
    maxValue = length chars - 1
    listLen = length password - length removed

  removed ++ Prelude.map (chars !!) (genRndIntList seed maxValue listLen)

randomReplace :: String -> String -> String
randomReplace symChars password = replace symChars password $ trials password

trials :: String -> Int
trials password = do
  let
    seed = djd2hash password - 2
    maxValue = length password `div` 3 :: Int
    listLen = 1

  1 + head (genRndIntList seed maxValue listLen) `mod` maxValue

replace :: [Char] -> String -> Int -> String
replace symChars password t = do
  if t == 0 || null password || null symChars then
    password
  else do
    let
      idxSeed = djd2hash password - 3
      symSeed = djd2hash password - 4
      maxIdx = length password - 1
      maxSym = length symChars - 1
      idxLen = t
      symLen = t

    let
      rdIdx = sort (genRndIntList idxSeed maxIdx idxLen) ++ [0]
      rdSym = map (symChars!!) (genRndIntList symSeed maxSym symLen) ++ " "

    replace' [] password rdIdx rdSym 0

replace' :: String -> String -> [Int] -> String -> Int -> String
replace' acc [] _ _ _ = acc
replace' acc rest [] _ _ = acc ++ rest
replace' acc rest _ [] _ = acc ++ rest
replace' acc (x:xs) (idx:idxs) (sym:syms) i = do
  if i == idx then
    replace' (acc ++ [sym]) xs idxs syms (i + 1)
  else
    replace' (acc ++ [x]) xs (idx:idxs) (sym:syms) (i + 1)
