# Test FasBashLib

FasBashLib has original test tools written in Bash.

## See test result

You can check the test result run on GitHub Action

See [GitHub Action Check Lib](https://github.com/Hayao0819/FasBashLib/actions/workflows/check.yaml)

## Run test yourself

FasBashLib has own test tool.

Clone this repository and run it.

```bash
make test
```

## Add test for new function

Replace `LIBNAME` and `FUNCNAME` to the library name and function which you want to add test.

### Create templetes

```bash
./bin/GenTestFiles.sh LIBNAME
```

### Write test script

Write Run.sh (`/tests/LIBNAME/FUNCNAME/Run.sh`) for test.

You can use the functions of the library in the script.

For example, when testing Pacman.Run, all functions in the Pacman library and all dependency functions are available.

~~Script should exit with `0`.~~

Now, test tool supports any exit code. The test will fail if the expected and actual ones are different.

### Run your test script

```bash
./bin/GenTestResult.sh -r LIBNAME FUNCNAME
```

### Generate Result.txt

```bash
./bin/GenTestResult.sh LIBNAME FUNCNAME
```

### Run test

```bash
./bin/RunTests.sh
```
