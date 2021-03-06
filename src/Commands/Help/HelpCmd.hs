module Commands.Help.HelpCmd
  ( helpCmd
  , afterHelp
  ) where

helpCmd :: String
helpCmd =
    "\
    \Usage: hhak [-h, --help] [-v, --version] <title> (<preset>) [options]\n\
    \\n\
    \Command:\n\
    \    -h, --help\n\
    \        Display the help of Hhak.\n\
    \    -v, --version\n\
    \        Display the version of Hhak.\n\
    \Title:\n\
    \    The name of the service.\n\
    \Preset:\n\
    \    This feature has not been implemented yet.\n\
    \    The pre-prepared setting for password generation (you can add a preset to ~/.hhakrc).\n\
    \Options:\n\
    \    Specify additional functions as needed.\n\
    \    Hhak will use the optional settings in preference to the preset ones.\n\
    \    The following values of the options mean the default values in this app. If you omit a option, Hhak will use them.\n\
    \    -d, --display\n\
    \        Display the password in the terminal.\n\
    \    -f, --force (deprecated)\n\
    \        This feature has not been implemented yet.\n\
    \        Forcibly generate a password which may be insecure, such as a password whose length is less than 12 or a password which has only lower-case.\n\
    \    --len=20\n\
    \        Set a password length. If it is less than 12, you cannot generate the password basically.\n\
    \    --sym=!\"#$%&‘()*+,-./:;<=>?@[\\]^_`{|}~\n\
    \        Set symbols used the password generation.\n\
    \    --algo=2b\n\
    \        Set an algorithm of BCrypt. You can use \"2\", \"2a\", \"2y\" and \"2b\".\n\
    \    --cost=10\n\
    \        Set a cost of BCrypt. It must be between 4 and 31. The actual rounds of stretching are 2^n."

afterHelp :: String -> IO ()
afterHelp = putStrLn
