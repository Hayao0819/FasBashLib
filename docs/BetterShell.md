# BetterShell

よく使う構文をシンプルに書けるようにした関数

## Overview

For文やecho文など、コーディングで多用する文を短く記述できる関数です。

## Index

* [GetLine()](#getline)
* [CutLastString()](#cutlaststring)
* [IsUUID()](#isuuid)

### GetLine()

標準入力から指定された行を抽出します
headコマンドとtailコマンドのシンプルなラッパーです

#### Example

```bash
cat file.txt | GetLine 4
```

#### Arguments

* **$1** (行番号):

#### Output on stdout

* 標準出力の指定された行

### CutLastString()

後方最長一致を行います
後ろで一致した文字列を除外して出力します

#### Example

```bash
CutLastString "HelloWorld!ILoveArchLinux" "Linux"
```

#### Arguments

* **$1** (最後を除外するための長い文字列):
* **$2** (末尾に一致する文字列):

#### Exit codes

* **0**: return only 0

#### Output on stdout

* $1 から 末尾の $2 を削除した文字列

### IsUUID()

文字列がUUIDかどうかを確認します

#### Arguments

* **$1** (確認する文字列):

#### Exit codes

* **0**: $1はUUIDです
* **1**: $1はUUIDではありません

