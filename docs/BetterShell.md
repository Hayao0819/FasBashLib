
# BetterShell

よく使う構文をシンプルに書けるようにした関数

## Overview

引数で指定されたものを1行づつ出力します

## Index

* [PrintArray()](#printarray)
* [ArrayIndex()](#arrayindex)
* [ArrayAppend()](#arrayappend)
* [GetBaseName()](#getbasename)
* [GetLine()](#getline)
* [ForEach()](#foreach)
* [CheckFuncDefined()](#checkfuncdefined)
* [IsUUID()](#isuuid)
* [RandomString()](#randomstring)
* [CutLastString()](#cutlaststring)

### PrintArray()

引数で指定されたものを1行づつ出力します

#### Example

```bash
hoge=("item1" "item2" "item3")
PrintArray "${hoge[@]}"
PrintArray Apple Banana Orange
```

#### Arguments

* **...** (出力する文字列):

#### Exit codes

* **0**: return only 0

#### Output on stdout

* 引数に指定された文字列を1行づつ出力します。何も指定されなかった場合は何も出力しません。

### ArrayIndex()

配列の要素数を返します

#### Example

```bash
NameList=(hoge fuga piyo)
ArrayIndex NameList
```

#### Arguments

* **$1** (配列名（配列をシェル展開しないでください）):

#### Variables set

* **#** (@set):

#### Exit codes

* **0**: 正常終了

#### Output on stdout

* 指定された配列の要素数

### ArrayAppend()

指定された配列に標準入力の内容を1行づつ追加します
内部でreadarrayを使用しているため、標準入力の引き渡しに配列を使用しないでください。
パイプはサブシェルとして実行され、配列の変更内容が破棄されます。
未定義の配列名が渡された場合は新たに定義されます。スコープは最初に定義した場所に依存します。

#### Example

```bash
NameList=(hoge fuga piyo)
ArrayAppend NameList < /path/to/namelist
```

#### Arguments

* **$1** (配列名（配列をシェル展開しないでください）):

#### Variables set

* 指定された配列を新たに定義します

#### Exit codes

* **0**: 正常終了

#### Output on stdout

* 何も出力しません

### GetBaseName()

標準入力から1行づつファイル一覧を受け取りファイル名のみを出力します。

#### Example

```bash
find . | GetBaseName
```

#### Exit codes

* **0**: return only 0

#### Output on stdout

* 標準入力から受け取ったパスのファイル名

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

### ForEach()

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

### CheckFuncDefined()

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

### IsUUID()

文字列がUUIDかどうかを確認します

#### Arguments

* **$1** (確認する文字列):

#### Exit codes

* **0**: $1はUUIDです
* **1**: $1はUUIDではありません

### RandomString()

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

