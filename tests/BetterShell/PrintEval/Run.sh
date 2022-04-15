# shellcheck disable=SC2148,SC2034

Variable=HOGEHOGE

PrintEval Variable

HOGEHOGE=PIYOPIYO

PrintEval "$Variable"
