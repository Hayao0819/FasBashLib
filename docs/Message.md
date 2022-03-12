# Message

A library to echo messages with simple label

## Overview

このライブラリはechoコマンドのシンプルなラッパーです。

メッセージをラベルと共に適切な場所へ出力します。例えば、Error メッセージはstdoutへ出力されます。

## Index

* [MsgErr()](#msgerr)
* [MsgInfo()](#msginfo)
* [MsgWarn()](#msgwarn)
* [MsgDebug()](#msgdebug)

### MsgErr()

Output error to stderr

#### Arguments

* $* string A value to print

#### Exit codes

* **0**: This script return only 0

### MsgInfo()

Output info to stdout

#### Arguments

* $* string A value to print

#### Exit codes

* **0**: This script return only 0

### MsgWarn()

Output warning to stderr

#### Arguments

* $* string A value to print

#### Exit codes

* **0**: This script return only 0

### MsgDebug()

Output debug message to stderr

#### Arguments

* $* string A value to print

#### Exit codes

* **0**: This script return only 0

