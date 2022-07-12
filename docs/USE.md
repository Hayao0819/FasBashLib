# Use this library in your script

There are two ways to use this library.

## Stable library Online

See [Release Page](https://github.com/Hayao0819/FasBashLib/releases) to get the code to add into your script.

To update the library version, you should change URL manually.

### Get URL with script

Clone this project and run script

```bash
./tools.sh release link "v0.1.1"
```

## Stable library Offline

See [Release Page](https://github.com/Hayao0819/FasBashLib/releases) and download `fasbashlib.sh`


## The latest dev library Online

Add this line into your script. You should connect to the Internet.

```bash
source /dev/stdin < <(curl -sL "https://raw.githubusercontent.com/Hayao0819/FasBashLib/build-0.1.x/fasbashlib.sh")
```

## The latest dev library Offline

See [Build documemt](./BUILD.md)

## Git submodule in your project

Add this repository as submodule

```bash
git submodule add https://github.com/Hayao0819/FasBashLib.git fasbashlib
git commit -m 'Add FasBashLib as a submodule'
```

Then you can build and load it at tha same time.

Write this code in your script. Do not forget to change the script path from time to time.

```bash
source /dev/stdin < <(./fasbashlib/bin/Build-Single.sh -out /dev/stdout)
```

You can change the build options as you like, as long as you don't forget to output to `/dev/stdout` .

This method may result in slower speeds because a library build occurs each time the script is executed.
