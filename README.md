# hhak

This is another project of [Dhak](https://github.com/ippee/dhak).  
Hhak has the same policy of Dhak, but it is written in Haskell.

**Note that Hhak is not compatible with Dhak.**

## Syntax of Hhak

```
hhak [-h, --help] [-v, --version] <title> [options]
```

### Command

- -h, \--help
  - Display the help.
- -v, \--version
  - Display the version.

### Title

The name of the service.

### Options

Specify additional functions as needed.

Hhak will use settings of options in preference to settings of presets.  
The following values of the options mean the default values in this app. If you omit a option, Hhak will use them.

- -d, \--display
    - Display the password in the terminal.
- \--len=20
    - Set a password length.
    - If it is less than 12, you cannot generate the password basically.
- \--sym=!"#$%&‘()*+,-./:;<=>?@\[\\]^_`{|}~
    - Set symbols used the password generation.
    - You can use any symbols except lower-case, upper-case and numbers.
    - You will get passwords without symbols if you keep this empty like `--sym=''`.
- \--cost=10
    - Set a cost of BCrypt. It must be between 4 and 31.
    - The cost is an exponent, and the actual round of stretching is 2^n.
    - The higher the cost, the more secure the password will be generated, but also the higher the computational load.

## Planned

- Support for .hhakrc
- Implement the option to change the BCrypt algorithm
- Implement the option to generate a password forcibly
