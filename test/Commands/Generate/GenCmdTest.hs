module Commands.Generate.GenCmdTest
  ( specGenCmd
  ) where

import Test.Hspec ( describe, it, shouldBe, shouldNotBe, Spec )
import Commands.Generate.GenCmd ( genCmd )
import Args.HhakArgs ( HhakArgs (..), Options (..), Algorithm (..), defaultOptions, defaultHhakArgs )
import Util.StringOperation ( include )
import Data.Either (fromRight)

specGenCmd :: Spec
specGenCmd = do
  let defaultPass = genCmd defaultHhakArgs

  describe "Normal behavior" $ do
    it "change passphrase" $ do
      let result = genCmd defaultHhakArgs { passphrase = "sample" }
      result `shouldNotBe` defaultPass

    it "change title" $ do
      let result = genCmd defaultHhakArgs { title = "GitHub" }
      result `shouldNotBe` defaultPass

    it "change password length" $ do
      let result = genCmd defaultHhakArgs { options = defaultOptions { len = 10 } }
      length result `shouldBe` 10

    it "change cost" $ do
      let result = genCmd defaultHhakArgs { options = defaultOptions { cost = 5 } }
      result `shouldNotBe` defaultPass

    it "generate password without symbols" $ do
      let result = filter (\c -> not $ include [c] (['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']))
                   $ genCmd defaultHhakArgs { options = defaultOptions { sym = "" } }
      length result `shouldBe` 0
