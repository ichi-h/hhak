module Args.ParseArgs.SepAtOptions
  ( sepAtOptions
  ) where

sepAtOptions :: [String] -> [String] -> ([String], [String])
sepAtOptions acc [] = (acc, [])
sepAtOptions acc (arg:args) =
    if head arg == '-' then
      (acc, arg:args)
    else
      sepAtOptions (acc++[arg]) args
