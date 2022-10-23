#!/usr/bin/env bash
# shellcheck source=/dev/null
current_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/../" && pwd)
source <("$current_dir/tools.sh" build single Cache -out /dev/stdout 2> /dev/null)


# キャッシュの存在チェック
Cache.Exist "MyTextPage" || echo "Cache does not exist."

# キャッシュの作成
Cache.Create "MyTextPage" > /dev/null << EOF
Hello World!
Welcome To FasBashLib
EOF

# キャッシュの取得
Cache.Get "MyTextPage" | wc -l | sed "s| *||g"

# キャッシュの存在チェック
Cache.Exist "MyTextPage" && echo "Cache exists !"

# 利用例
date | Cache.Create "MyTextPage" > /dev/null
sleep 2
echo "Cached date: "
Cache.Get "MyTextPage"
echo "Current date: "
date
