
# Cache 

キャッシュの作成、呼び出し、管理を行います。

## Overview

Cacheライブラリは、${TMPDIR}以下にデータを保存するテキストファイルを作成します。

これにより、コマンドの実行結果をキャッシュとして保存することが可能になります。

環境変数 `FSBLIB_CACHEID` をディレクトリ名として使用します。

環境変数は関数によって自動的に定義され、同じ値をスクリプトで直接定義することで変数が共有されない範囲でもデータを受け渡すことができます。

## Index

* [CreateDir()](#createdir)

### CreateDir()

キャッシュを保存するためのディレクトリを${TMPDIR}以下に作成します

この関数はさまざまな関数からディレクトリを参照する際に呼び出されるので、通常はスクリプト内で明示的に呼び出す必要はありません。

Cache.Create や Cache.GetID, Cache.GetDir などから呼び出されます。

この関数を初めて実行したのがサブシェル内である場合、FSBLIB_CACHEID 変数が引き継がれないため、関数を呼び出せない可能性があります。

最初にサブシェル外でこのコマンドを実行することで、サブシェル内でもFSBLIB_CACHEID を引き継ぐことができます。

#### Example

```bash
Cache.CreateDir > /dev/null
```

_Function has no arguments._

#### Variables set

* FSBLIB_CACHEID

#### Exit codes

* **0**: ディレクトリの作成に成功しました
* **1**: mkdirがなんらかの理由でディレクトリを作成できませんでした

#### Output on stdout

* 作成されたディレクトリのパスを出力します。  通常は不要なので、破棄してください。
