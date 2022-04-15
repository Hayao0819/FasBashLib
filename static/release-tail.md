
## Load in script with curl

### UpperCase Version

```bash
# shellcheck source=/dev/null
source /dev/stdin < <(
    fasbashlib -x "%TAG%" 2> /dev/null || curl -sL "%SOURCEURL%"
)
```

### SnakeCase Version

```bash
# shellcheck source=/dev/null
source /dev/stdin < <(
    fasbashlib -s -x "%TAG%" 2> /dev/null || curl -sL "%SNAKESOURCEURL%"
)
```
