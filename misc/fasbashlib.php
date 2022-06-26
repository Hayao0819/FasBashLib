<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FasBashLib Loader</title>
</head>
<body>
<?php
    # http://example.com/fasbashlib.php?lib=Pacman&ver=v0.2.3
    # って渡されたときに
    # 1. コミットIDの特定
    # 2. GitHub Actionsから該当のコードを取得
    # 3. ファイルを全部結合してコメントと空行を削除して出力
    #
    # シェルスクリプト側の実装はこんな感じ
    # source <(curl -sL "http://example.com/fasbashlib.php?lib=Pacman&ver=v0.2.3" )
?>

</body>
</html>

