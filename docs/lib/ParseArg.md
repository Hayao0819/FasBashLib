
# ParseArg

GNU getoptのように動作する小さいコマンドラインパーサー

## Overview

GNU getoptのように引数を解析して並び替えを行う関数です。

全てBashで記述されており、BSD環境でも動作します。

## Index

* [ParseArg()](#parsearg)

### ParseArg()

GNU getoptの最小限の機能をBashで実装した関数です。

getoptと同じフォーマットで引数を指定できます。

This function does not support the option argument (Example: 'a::')

#### Arguments

* LONG  GNU getopt's long option
* SHORT GNU getopt's short option

#### Variables set

* **OPTRET** (解析された結果):

#### Exit codes

* **0**: 正常に解析が終了しました
* **1**: 定義されていない不正なオプション
* **2**: 必要な引数が指定されていません

