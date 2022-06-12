# shellcheck disable=SC2148,SC2034

MyURLExample="scheme://username@sub.host.top.domain:8080/path/to/file?q1=string1&q2=string2#fragment"

URL.HasPort <<< "${MyURLExample}"
