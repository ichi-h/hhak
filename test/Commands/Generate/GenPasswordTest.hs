module Commands.Generate.GenPasswordTest
  ( specGenPassword
  ) where

import Test.Hspec ( describe, it, shouldBe, shouldNotBe, Spec )
import Commands.Generate.GenPassword ( genPassword )
import Args.HhakArgs ( HhakArgs (..), Options (..), Algorithm (..), defaultOptions, defaultHhakArgs )
import Util.StringOperation ( include )

specGenPassword :: Spec
specGenPassword = do
  let defaultPass = genPassword defaultHhakArgs

  describe "Normal behavior" $ do
    it "change passphrase" $ do
      let result = genPassword defaultHhakArgs { passphrase = "sample" }
      result `shouldNotBe` defaultPass

    it "change title" $ do
      let result = genPassword defaultHhakArgs { title = "GitHub" }
      result `shouldNotBe` defaultPass

    it "change password length" $ do
      let result = genPassword defaultHhakArgs { options = defaultOptions { len = 10 } }
      length result `shouldBe` 10

    it "change cost" $ do
      let result = genPassword defaultHhakArgs { options = defaultOptions { cost = 5 } }
      result `shouldNotBe` defaultPass

    it "generate password without symbols" $ do
      let result = filter (\c -> not $ include [c] (['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']))
                   $ genPassword defaultHhakArgs { options = defaultOptions { sym = "" } }
      length result `shouldBe` 0
