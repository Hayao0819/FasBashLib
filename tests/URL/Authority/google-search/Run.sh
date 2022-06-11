# shellcheck disable=SC2148,SC2034
MyURLExample="https://www.google.com/search?q=github.com&oq=github.com&sourceid=chrome&ie=UTF-8"

URL.Authority <<< "${MyURLExample}"
