
## Load in script with curl

### UpperCase Version

```bash
# shellcheck source=/dev/null
source /dev/stdin < <(curl -sL "%SOURCEURL%")
```

### SnakeCase Version

```bash
# shellcheck source=/dev/null
source /dev/stdin < <(curl -sL "%SNAKESOURCEURL%")
```
