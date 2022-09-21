
## Index

* [Append](#append)
* [Push](#push)
* [Print](#print)
* [Length](#length)

### Append

指定された配列に標準入力の内容を1行づつ追加します
内部でreadarrayを使用しているため、標準入力の引き渡しにパイプを使用しないでください。
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

### Push

指定された配列に要素を1つ追加します

#### Example

```bash
NameList=(hoge fuga piyo)
Array.Push NameList yamada
Array.Eval NameList # hoge fuga piyo yamada
```

#### Arguments

* **$1** (配列名（配列をシェル展開しないでください）):
* **$2** (追加する要素):

#### Variables set

* 指定された配列を新たに定義します

#### Exit codes

* **0**: 正常終了

#### Output on stdout

* 何も出力しません

### Print

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

### Length

配列の要素数を返します

#### Example

```bash
NameList=(hoge fuga piyo)
Array.Length NameList
```

#### Arguments

* **$1** (配列名（配列をシェル展開しないでください）):

#### Variables set

* **#** (@set):

#### Exit codes

* **0**: 正常終了

#### Output on stdout

* 指定された配列の要素数

