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
  let defaultPass = fromRight "" $ genCmd defaultHhakArgs

  describe "Normal behavior" $ do
    it "change passphrase" $ do
      let result = genCmd defaultHhakArgs { passphrase = "sample" }
      case result of
        Left err       -> fail err
        Right password -> password `shouldNotBe` defaultPass

    it "change title" $ do
      let result = genCmd defaultHhakArgs { title = "GitHub" }
      case result of
        Left err       -> fail err
        Right password -> password `shouldNotBe` defaultPass

    it "change password length" $ do
      let result = genCmd defaultHhakArgs { options = defaultOptions { len = 10 } }
      case result of
        Left err       -> fail err
        Right password -> length password `shouldBe` 10

    it "change cost" $ do
      let result = genCmd defaultHhakArgs { options = defaultOptions { cost = 5 } }
      case result of
        Left err       -> fail err
        Right password -> password `shouldNotBe` defaultPass

    it "generate password without symbols" $ do
      let result = filter (\c -> not $ include [c] (['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']))
                   $ fromRight ""
                   $ genCmd defaultHhakArgs { options = defaultOptions { sym = "" } }
      length result `shouldBe` 0
