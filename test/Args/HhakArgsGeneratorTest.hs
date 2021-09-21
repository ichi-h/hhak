module Args.HhakArgsGeneratorTest
  ( specGenHhakArgs
  ) where

import Test.Hspec ( describe, it, shouldBe, Spec )
import Args.HhakArgsGenerator ( genHhakArgs )
import Args.HhakArgs ( HhakArgs (..), Options (..), Algorithm (..), defaultOptions, defaultHhakArgs )

specGenHhakArgs :: Spec
specGenHhakArgs = do
  describe "Normal behavior" $ do
    it "(No arguments)" $ do
      let result = genHhakArgs []
      let expected = defaultHhakArgs { command = "help" }
      case result of
        Left err       -> fail err
        Right hhakArgs -> show hhakArgs `shouldBe` show expected

    it "-h" $ do
      let result = genHhakArgs ["-h"]
      let expected = defaultHhakArgs { command = "help" }
      case result of
        Left err       -> fail err
        Right hhakArgs -> show hhakArgs `shouldBe` show expected

    it "--help" $ do
      let result = genHhakArgs ["--help"]
      let expected = defaultHhakArgs { command = "help" }
      case result of
        Left err       -> fail err
        Right hhakArgs -> show hhakArgs `shouldBe` show expected

    it "-v" $ do
      let result = genHhakArgs ["-v"]
      let expected = defaultHhakArgs { command = "version" }
      case result of
        Left err       -> fail err
        Right hhakArgs -> show hhakArgs `shouldBe` show expected

    it "--version" $ do
      let result = genHhakArgs ["--version"]
      let expected = defaultHhakArgs { command = "version" }
      case result of
        Left err       -> fail err
        Right hhakArgs -> show hhakArgs `shouldBe` show expected

    it "GitHub presetName --display --force" $ do
      let result = genHhakArgs ["GitHub", "presetName", "--display", "--force"]
      let expected = defaultHhakArgs { command = "generate"
                                     , title   = "GitHub"
                                     , preset  = "presetName"
                                     , options = defaultOptions { display = True
                                                                , force   = True
                                                                }
                                     }
      case result of
        Left err       -> fail err
        Right hhakArgs -> show hhakArgs `shouldBe` show expected

    it "GitHub presetName -df --len=40 --sym= --algo=2a --cost=12" $ do
      let result = genHhakArgs [ "GitHub"
                               , "presetName"
                               , "-df"
                               , "--len=40"
                               , "--sym="
                               , "--algo=2a"
                               , "--cost=12"
                               ]
      let expected = defaultHhakArgs { command = "generate"
                                     , title   = "GitHub"
                                     , preset  = "presetName"
                                     , options = defaultOptions { display = True
                                                                , force   = True
                                                                , len     = 40
                                                                , sym     = ""
                                                                , algo    = Algo2a
                                                                , cost    = 12
                                                                }
                                     }
      case result of
        Left err       -> fail err
        Right hhakArgs -> show hhakArgs `shouldBe` show expected
