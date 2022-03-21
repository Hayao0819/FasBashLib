## FasBashLib - A collection of small functions for Bash

<p>
    <a href="/LICENSE.md">
        <img src="https://img.shields.io/badge/license-MIT--SUSHI-orange?style=flat-square">
    </a>
    <a href="https://github.com/Hayao0819/FasBashLib/actions">
        <img src="https://img.shields.io/github/workflow/status/Hayao0819/FasBashLib/Test%20library">
    </a>
    <a href="https://github.com/Hayao0819/FasBashLib/stargazers">
        <img src="https://img.shields.io/github/stars/Hayao0819/FasBashLib?color=yellow&style=flat-square&logo=github">
    </a>
    <a href="https://github.com/Hayao0819/FasBashLib/commits/">
        <img src="https://img.shields.io/github/last-commit/Hayao0819/FasBashLib?style=flat-square">
    </a>
    <a href="https://github.com/Hayao0819/FasBashLib/">
        <img src="https://img.shields.io/github/repo-size/Hayao0819/FasBashLib?style=flat-square">
    </a>
    <a href="https://github.com/Hayao0819/FasBashLib">
        <img src="https://img.shields.io/tokei/lines/github/Hayao0819/FasBashLib?style=flat-square">
    </a>
</p>

A collection of small functions designed to quickly write secure code in Bash 5.x. 

Some functions are also for Arch Linux.

## Document

You can read the latest auto generated documents [here](https://github.com/Hayao0819/FasBashLib/tree/build-dev/docs).

Or download document from [Release Page](https://github.com/Hayao0819/FasBashLib/releases)

## Use this library in your script

There are two ways to use this library.

### Stable library Online

See [Release Page](https://github.com/Hayao0819/FasBashLib/releases) to get the code to add into your script.

To update the library version, you should change URL manually.

#### Get URL with script

Clone this project and run `./bin/GetLink.sh`

```bash
./bin/GetLink.sh "v0.1.1"
```

### Stable library Offline

See [Release Page](https://github.com/Hayao0819/FasBashLib/releases) and download `fasbashlib.sh`


### The latest dev library Online

Add this line into your script. You should connect to the Internet.

```bash
source /dev/stdin < <(curl -sL "https://raw.githubusercontent.com/Hayao0819/FasBashLib/build-0.1.x/fasbashlib.sh")
```

### The latest dev library Offline

Build library and source it in your script.

Run this following command (Do not write it on your script)

```bash
# Download source code
git clone --recursive "https://github.com/Hayao0819/FasBashLib.git"
cd ./FasBashLib/

# Build all library
make

# Build library you need
bash ./bin/SingleFile.sh [Lib1] [Lib2] ...
```

Now, you can find built shellscript in the root of repository.

## Special thanks

- [readlinkf](https://github.com/ko1nksm/readlinkf) - The functions in `Readlink.sh` are taken from this repository.
- [shdoc](https://github.com/reconquest/shdoc) - Script to generate documentation from source code
- [Bash-minifier](https://github.com/Zuzzuc/Bash-minifier) - Script used to minify bash scripts
- [MIT-SUSHI-WARE](https://github.com/watasuke102/mit-sushi-ware) - MIT-derived license that only wants copyright notice and sushi
