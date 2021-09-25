module Args.HhakArgsGeneratorTest
  ( specGenHhakArgs
  ) where

import Test.Hspec ( describe, it, shouldBe, Spec )
import Args.HhakArgsGenerator ( genHhakArgs )
import Args.HhakArgs ( HhakArgs (..), Options (..), Algorithm (..), defaultOptions, defaultHhakArgs )

specGenHhakArgs :: Spec
specGenHhakArgs = do
  describe "GenHhakArgs" $ do
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

    describe "Abnormal behavior" $ do
      it "-x (unknown option)" $ do
        let result = genHhakArgs ["-x"]
        case result of
          Left err -> err `shouldBe` "'-x' is unknown option."
          Right _  -> fail "Unknown options passed test."

      it "GitHub presetName -h (unknown option)" $ do
        let result = genHhakArgs ["GitHub", "presetName", "-h"]
        case result of
          Left err -> err `shouldBe` "'-h' is unknown option."
          Right _  -> fail "Arguments with syntax error passed test."

      it "GitHub presetName foo bar -x (unknown arguments)" $ do
        let result = genHhakArgs ["GitHub", "presetName", "foo", "bar", "-x"]
        case result of
          Left err -> err `shouldBe` "'foo, bar' is unknown argument."
          Right _  -> fail "Unknown arguments passed test."

      it "GitHub -d presetName (syntax error)" $ do
        let result = genHhakArgs ["GitHub", "-d", "presetName"]
        case result of
          Left err -> err `shouldBe` "'presetName' is unknown option."
          Right _  -> fail "Arguments with syntax error passed test."
