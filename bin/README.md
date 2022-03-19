## 管理ツール

ライブラリを管理するためのスクリプトです。

### CheckLib.sh

設定が正常に行われているかを確認します。

### GenDoc.sh

ソースコードからドキュメントを生成します。

### GenTestFiles.sh

テストに必要なファイルのテンプレートを生成します。

### GenTestResult.sh

テストスクリプト（`Run.sh`）を実行して結果を`Result.txt`に書き込みます。

### GetLibList.sh

ライブラリの一覧を出力します。

### MultiFile.sh

複数ファイルで構成されたファイルラリをビルドします。

### RunTests.sh

テストを実行します。`Run.sh`がバックグラウンドで並列して実行され、標準出力が`Result.txt`と比較されます。

### SingleFile.sh

指定されたライブラリから単体のスクリプトを作成します。
