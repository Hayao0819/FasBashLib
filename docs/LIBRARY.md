# ライブラリの仕様

すべてのライブラリは以下の仕様に従って記述されています。

これらによって、管理ツールを利用したテストやビルドが可能になります。

## ディレクトリ構造

`/src`以下のディレクトリ1つを「1つのライブラリ」として管理します。

通常、ライブラリには同じジャンルの関数が含まれるべきです。

ライブラリは最低でも2つのファイルを持っています。

### Meta.ini

ライブラリの情報を記述したファイルであり、すべてのライブラリに必須です。

Meta.Iniの完全な仕様は`/misc/example-Meta.ini`を参照してください。

### スクリプトファイル

実際の関数が記述されたシェルスクリプトです。

このファイルは`Build-Single.sh`によって読み込まれるファイルのため、Bashの文法の他に以下の独自のルールに従って記述する必要があります。

特に関数呼び出しや関数定義は独特のルールを持っています。

- 関数以外のコードを記述しない
  
  関数の外にコードを書くことやグローバル変数を記述することは許可されていません
  
  これらのコードはビルド時に無視されます

- アッパーキャメルケースで記述する

- 関数定義時の名称に注意する
  
  `Meta.ini`で`Prefix`を設定しており、シェルファイル内で`FuncName()`を定義している場合、ビルド後の関数名は`Prefix.FuncName`となります。

- 同じライブラリ内の別の関数を呼び出すときは`Prefix`の代わりに`@`を利用する
  
  `Prefix=Apple`というライブラリ内で`MyFunc1`から`MyFunc2`を呼び出す場合、`MyFunc1`の内では`@MyFunc2`と記述します。（`Apple.Myfunc2`や`@.MyFunc2`ではありません）

- スクリプトは分割できますが、すべてのファイルパスを`Meta.ini`に記述する必要があります。

### 上記以外のファイル

`Meta.ini`で`Embedded`セクションを定義した場合、ファイルをシェルスクリプトに埋め込む事が可能です。

この機能はヒアドキュメントを利用すること想定しています。

`Meta.ini`で代替名とパスを定義し、スクリプト側には`%代替名%`と記述してください。

ここで注意するべきことはスクリプト側の記述位置です。必ず行頭に位置する必要があり、行の途中（インデント含む）に記述された場合は無視されます。

```bash
# 正常なコード
# %MYPYTHONCODE%がファイルの内容に置き換えられます
cat << EOF
%MYPYTHONCODE%
EOF

# 間違ったコード
# これらのコードは無視されます
echo "%MYPYTHONCODE%"

cat << EOF
    %MYPYTHONCODE%
EOF

cat << EOF
%MYPYTHONCODE% something
EOF
```

### 例

#### src/MyLib/Meta.ini

```ini
[FsbLib]
Name = MyLib
Description = 自分だけの関数
Depends = python3, jq
Require = BetterShell
Shell = ModernBash
Files = ./Main.sh , ./Old.sh
Prefix = Hayao

[Test]
SkipAll = false

[Const]
FSBLIB_Hayao_BirthDay=20040819
FSBLIB_Hayao_EMail=hayao@fascode.net

[Embedded]
MyPythonCode=./hello.py
```

#### src/MyLib/Main.sh

```bash
#!/usr/bin/env bash

SayHelloWithBash(){
    echo "Hello World"
}
```

#### src/MyLib/Old.sh

```bash
#!/usr/bin/env bash

SayHelloWithPython(){
    python3 << EOF
%MyPythonCode%
EOF
    return 0
}
```

#### src/MyLib/hello.py

```python
#!/usr/bin/env python3
print("Hello World");
```

#### ビルド後

```bash
#!/usr/bin/env bash
# コメント、共通コード省略

Hayao.SayHelloWithBash(){
    echo "Hello World"
}

Hayao.SayHelloWithPython(){
    python3 << EOF
#!/usr/bin/env python3
print("Hello World");
EOF
    return 0
}
```


