module Commands.Generate.HashPassphrase
  ( hashPassphrase
  ) where

import Args.HhakArgs ( HhakArgs (title, passphrase) )
import Data.ByteString as BS ( ByteString )
import Data.ByteString.UTF8 as BSU ( fromString )
import Crypto.Hash ( hash, SHA3_512, Digest )

hashPassphrase :: HhakArgs -> String
hashPassphrase hhakArgs = do
  sha3_512 $ BSU.fromString $ title hhakArgs ++ passphrase hhakArgs

sha3_512 :: BS.ByteString -> String
sha3_512 bs = show (hash bs :: Digest SHA3_512)
