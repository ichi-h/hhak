module Commands.Generate.GenCmdTest
  ( specGenCmd
  ) where

import Test.Hspec ( describe, it, shouldBe, shouldNotBe, Spec )
import Commands.Generate.GenCmd ( genCmd, GenResult (..) )
import Args.HhakArgs ( HhakArgs (..), Options (..), Algorithm (..), defaultOptions, defaultHhakArgs )
import Util.StringOperation ( include )
import Data.Either (fromRight)

specGenCmd :: Spec
specGenCmd = do
  let defaultPass = genCmd defaultHhakArgs

  describe "GenCmd" $ do
    describe "Normal behavior" $ do
      it "change passphrase" $ do
        let result = genCmd defaultHhakArgs { passphrase = "sample" }
        show result `shouldNotBe` show defaultPass

      it "change title" $ do
        let result = genCmd defaultHhakArgs { title = "GitHub" }
        show result `shouldNotBe` show defaultPass

      it "change password length" $ do
        let result = password $ genCmd defaultHhakArgs { options = defaultOptions { len = 10 } }
        length result `shouldBe` 10

      it "change cost" $ do
        let result = genCmd defaultHhakArgs { options = defaultOptions { cost = 5 } }
        show result `shouldNotBe` show defaultPass

      it "generate password without symbols" $ do
        let result = filter (\c -> not $ include [c] (['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']))
                    $ password
                    $ genCmd defaultHhakArgs { options = defaultOptions { sym = "" } }
        length result `shouldBe` 0
