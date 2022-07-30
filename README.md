## FasBashLib - A collection of many personal functions for modern Bash

<p>
    <a href="/LICENSE.md">
        <img src="https://img.shields.io/badge/license-MIT--SUSHI-orange?style=flat-square">
    </a>
    <a href="https://github.com/Hayao0819/FasBashLib/actions">
        <img src="https://img.shields.io/github/workflow/status/Hayao0819/FasBashLib/Test%20library?style=flat-square">
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

A collection of many personal functions for modern Bash to write safe and readable code quickly

They are grouped by function type, and some functions are specific to a particular system.

I like Arch Linux, so there may be many for it.

## Features
These are only part of FasBashLib's main libraries.

- Supports 3 coding styles, `Upper camel case` , `Lower camel case`, and `Snake case`
- Select and build only the functions you need
- Automatically generate documents from source code comments
- Unique test tool specially designed
- Safe and easy array operation (`Array`)
- Batch analysis of URLs from standard input (`URL`)
- Arch Linux-specific functions (`Aur`, `ArchLinux`, `Pacman`, `SrcInfo`)

## Why?

Modern Bash is feature-rich, making it possible to write secure code compared to pure shells.

If you are coding utilizing these features, you will find yourself writing the same code over and over again.

Also, Bash has no type restrictions, so even something as simple as evaluating boolean values can become redundant if you consider safety.

This library has many functions, especially for arrays, that make it easy to write safe code that takes special characters such as whitespace into account.

## Use it

See [How to use it](./docs/USE.md)

## Document

You can read the latest auto generated documents [here](https://github.com/Hayao0819/FasBashLib/tree/build-0.2.x/docs/lib).

Or download document from [Release Page](https://github.com/Hayao0819/FasBashLib/releases)

## Test

See [How to test](./docs/TEST.md)

## Code examples

You can add your script to this list. Please send a Pull request.

- [10 Number Game](https://gist.github.com/Hayao0819/caad8ef3952bdfef7287ef8c5d71e03c) - A simple game about math
- [Hayao0819/MisskeyBot](https://github.com/Hayao0819/MisskeyBot) - A Misskey Bot to renote automatically

## Special thanks

FasBashLib is composed of these projects. Deepest thanks to their contributors!

- [ko1nksm/readlinkf](https://github.com/ko1nksm/readlinkf) - The functions in `Readlink.sh` are taken from this repository.
- [reconquest/shdoc](https://github.com/reconquest/shdoc) - Script to generate documentation from source code
- [Zuzzuc/Bash-minifier](https://github.com/Zuzzuc/Bash-minifier) - Script used to minify bash scripts
- [mvdan/sh](https://github.com/mvdan/sh) - `Build-Single.sh` formats the generated scruples using shfmt.
- [ShellShoccar-jpn/Parsrs](https://github.com/ShellShoccar-jpn/Parsrs) - Simple parsers written in POSIX shell (for `Parsrs`)
- [watasuke102/MIT-SUSHI-WARE](https://github.com/watasuke102/mit-sushi-ware) - MIT-derived license that only wants copyright notice and sushi
