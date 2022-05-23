
# IniRead

Iniファイルを解析し、内容を出力します

## Overview

Ini設定ファイルを読み取り、以下のものを出力します
- セクションの一覧
- パラメータの一覧
- 指定されたパラメータの値

## Index

* [GetSectionList()](#getsectionlist)
* [GetParamList()](#getparamlist)
* [GetParam()](#getparam)

### GetSectionList()

Iniのセクションの一覧を取得します
Iniファイルは標準入力から受け取ります。

#### Example

```bash
cat config.ini | GetIniSectionList
```

_Function has no arguments._

#### Exit codes

* **0**: 正常に出力されました
* **1**: 一部の行で解析に失敗しました

#### Output on stdout

* セクションのリストを返します

### GetParamList()

指定されたセクション内のパラメータの一覧を表示します
Iniファイルは標準入力から受け取ります。

#### Example

```bash
cat chromium.desktop | GetIniParamList desktop
```

_Function has no arguments._

#### Exit codes

* **0**: 正常に出力されました
* **1**: 一部の行で解析に失敗しました

#### Output on stdout

* パラメータのリストを返します

### GetParam()

指定されたセクションのパラメータを表示します
Iniファイルは標準入力から受け取ります。

#### Example

```bash
cat chromium.desktop | GetParam Desktop Name
```

#### Arguments

* **$1** (セクション):
* **$2** (パラメータ):

#### Exit codes

* **0**: 正常に出力されました
* **1**: 一部の行で解析に失敗しました

#### Output on stdout

* 指定されたパラメータの値

