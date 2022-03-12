# shellcheck disable=SC2148,SC2034

String1="$(RandomString 20)"
String2="$(RandomString 30)"
String3="$(RandomString 30)"


# 文字数を確認
if ! [[ "${#String1}" = "20" ]]; then
    echo "文字数が引数と一致しません"
    exit 1
fi

# 同じ文字列
if [[ "$String2" = "$String3" ]]; then
    echo "文字列が一緒です"
    exit 1
fi

echo "全てが正常です"
