
# Message

A library to echo messages with simple label

## Overview

このライブラリはechoコマンドのシンプルなラッパーです。

メッセージをラベルと共に適切な場所へ出力します。例えば、Error メッセージはstdoutへ出力されます。

FSBLIB_MSG 環境変数を設定することで出力先を変更できます

## Index

* [Info](#info)
* [Warn](#warn)
* [Debug](#debug)

### Info

Output info to stdout

#### Arguments

* $* string A value to print

#### Exit codes

* **0**: This script return only 0

### Warn

Output warning to stderr

#### Arguments

* $* string A value to print

#### Exit codes

* **0**: This script return only 0

### Debug

Output debug message to stderr

#### Arguments

* $* string A value to print

#### Exit codes

* **0**: This script return only 0

