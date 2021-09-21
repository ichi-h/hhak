module Args.HhakArgsGeneratorTest
  ( specGenHhakArgs
  ) where

import Test.Hspec ( describe, it, shouldBe, Spec )
import Args.HhakArgsGenerator ( genHhakArgs )
import Args.HhakArgs ( HhakArgs (..), Options (..), Algorithm (..), defaultOptions )

specGenHhakArgs :: Spec 
specGenHhakArgs = do
  describe "Normal behavior" $ do
    it "(No arguments)" $ do
      let result = genHhakArgs []
      let expected = HhakArgs { command    = "help"
                              , passphrase = ""
                              , title      = ""
                              , preset     = ""
                              , options    = defaultOptions
                              }
      case result of
        Left err       -> fail err
        Right hhakArgs -> show hhakArgs `shouldBe` show expected
