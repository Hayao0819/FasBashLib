## FasBashLib - A collection of small functions for Bash

A collection of small functions designed to quickly write secure code in Bash 5.x. 

Some functions are also for Arch Linux.

## Document

You can read auto generated documents [here](https://github.com/Hayao0819/FasBashLib/tree/build-dev/docs).

## Use

There are two ways to use this library.

### The latest dev library Online

Add this line into your script.

```bash
source /dev/stdin < <(curl -sL https://raw.githubusercontent.com/Hayao0819/FasBashLib/build-dev/fasbashlib.sh)
```

### The latest dev library Offline

Build library and source it in your script.

Run this following command (Do not write it on your script)

```bash
# Download source code
git clone "https://github.com/Hayao0819/FasBashLib.git"
cd ./FasBashLib/

# Build all library
make

# Build library you need
bash ./bin/SingleFile.sh [Lib1] [Lib2] ...
```

And run `source`

```bash
source /path/to/your/fasbashlib.sh
```


## Special thanks

- [readlinkf](https://github.com/ko1nksm/readlinkf) - The functions in `Readlink.sh` are taken from this repository.
- [shdoc](https://github.com/reconquest/shdoc) - Script to generate documentation from source code
- [Bash-minifier](https://github.com/Zuzzuc/Bash-minifier) - Script used to minify bash scripts
- [MIT-SUSHI-WARE](https://github.com/watasuke102/mit-sushi-ware) - MIT-derived license that only wants copyright notice and sushi
