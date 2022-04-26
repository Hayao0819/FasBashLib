# Todo 

このライブラリは受験勉強の合間を縫ってちびちび開発しています。

## ライブラリ

実装したいけど時間がないもの

- Bgps(Background Process) 並列処理のための関数
  プロセス数の制限とかデータ共有とか...
- RESTAPI APIを叩くためのcurlラッパー
  ヘッダーとかステータスコードをうまく処理してくれたら嬉しいなぁ
- Md マークダウンの解析
  見出し一覧とか、特定のセクションの抽出とか
- Twitter
  Twitter APIをかんたんに扱えたらいいなぁって

## 改善

- `fasbashlib` コマンドのライブラリバージョンの互換性確認をもうちょい厳格にしたい
- LegacyShellとModernBashで分割したい（ディレクトリ名で分けるのもあり？？→ `LibName:ModernBash`みたいな感じ）
- LegacyShell（ashを想定）用に配列を実装したい
- このライブラリを使ってAlterISOのAURヘルパーを書き直したい（このプロジェクトではない）

## テスト本体

- Docker内での実行
- エラーが発生した行の表示
- ログ出力の改善（意見募集中）

## テストスクリプトの作成

Run `./bin/Test-NotFoundList.sh` for the latest todo

- ArchLinux
- Aur
- AwkForCalc
- BetterShell
- Cache
- Core
- Csv
- Ini
- Pacman
- Prompt
- Readlink
- SrcInfo
- URL

テストスクリプト書いてくれる人募集中
