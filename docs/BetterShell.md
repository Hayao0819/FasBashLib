
# BetterShell

よく使う構文をシンプルに書けるようにした関数

## Overview

標準入力から1行づつファイル一覧を受け取りファイル名のみを出力します。

## Index

* [GetBaseName](#getbasename)
* [GetLine](#getline)
* [ForEach](#foreach)
* [CheckFuncDefined](#checkfuncdefined)
* [IsUUID](#isuuid)
* [RandomString](#randomstring)
* [CutLastString](#cutlaststring)
* [RemoveBlank](#removeblank)
* [PrintEval](#printeval)

### GetBaseName

標準入力から1行づつファイル一覧を受け取りファイル名のみを出力します。

#### Example

```bash
find . | GetBaseName
```

#### Exit codes

* **0**: return only 0

#### Output on stdout

* 標準入力から受け取ったパスのファイル名

### GetLine

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

### ForEach

標準入力から値を読み取り、ループします
標準入力から1行ずつ読み取り、指定されたコマンドの引数に渡してコマンドを繰り返し実行します。
xargsと似ていますが、シェル関数なども利用できます。
引数には、代入を行う場所を`{}`で置き換えてください。

#### Example

```bash
find . -type f | ForEach mv "{}" "{}.bak"
```

#### Arguments

* **...** (実行するコマンドおよびその引数):

#### Exit codes

* **0**: 正常に実行されました
* 0以外 指定されたコマンドが0以外で終了し、ループを中止しました

#### Output on stdout

* 指定されたコマンドの出力をそのまま返します。この関数特有のものはありません。

### CheckFuncDefined

指定された関数が定義されているか確認します。

#### Example

```bash
function hoge(){ echo "HOGE!"; }
CheckFuncDefined hoge || echo "hoge is not defined"
```

#### Arguments

* **$1** (チェックする関数名):

#### Exit codes

* **0**: 関数は定義されています
* **1**: 関数は定義されていません

#### Output on stdout

* 何も出力しません

### IsUUID

文字列がUUIDかどうかを確認します

#### Arguments

* **$1** (確認する文字列):

#### Exit codes

* **0**: $1はUUIDです
* **1**: $1はUUIDではありません

### RandomString

ランダムな文字列を/dev/randomから生成します

#### Example

```bash
password=$(RandomString 15)
```

#### Arguments

* **$1** (桁数):

#### Exit codes

* **0**: If successful.
* **1**:  何かしらのコマンドが異常終了しました

#### Output on stdout

* ランダムな文字列

### CutLastString

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

### RemoveBlank

行頭行末の空行を除去します

標準入力から受け取ったテキストの、行頭と行末にある任意の数の空白文字やTab文字を削除します。

#### Example

```bash
echo "   Hello World ! I Love ArchLinux      " | RemoveBlank
```

_Function has no arguments._

#### Exit codes

* **0**: return only 0

#### Output on stdout

* stdinから行頭と末尾の空白を除去したもの

### PrintEval

指定された文字列の変数を参照します

指定された文字列の名前の変数を参照し、その値を返します。

引数として#と@を指定しても正常に動作しないことに気をつけてください。

引数の変数を展開しないでください

#### Example

```bash
MyVariable="Hello World"
PrintEval MyVariable
```

#### Arguments

* **$1** (変数名):

#### Exit codes

* **0**: return only 0

#### Output on stdout

* 指定された変数に代入されている値

