# Use this library in your script

There are many ways to use this library.

## Stable library Online

See [Release Page](https://github.com/Hayao0819/FasBashLib/releases) to get the code to add into your script.

To update the library version, you should change URL manually.

### Get URL with script

Clone this project and run script

```bash
./tools.sh release link "v0.1.1"
```


## Install stable library on system with multiple version

Please install FasBashLib by the method of each OS. Then load the library with the code below.

Currently this method does not work properly if the library is not installed on the system.

In the future, it will be automatically loaded from online if it is not installed.

```
source <(fasbashlib -x 380bcf011aa07386afc0db43bb2232e71cc7cbc0-upper Ini Pacman)
```

Please run `fasbashlib -h` to see all usage.


### Arch Linux

Install FasBashLib with pacman

```bash
git clone https://github.com/Hayao0819/FasBashLib.git
cd FasBashLib/pkg/fasbashlib-git/
makepkg -si
```

### Other Linux , BSD, or macOS


```bash
git clone https://github.com/Hayao0819/FasBashLib.git
cd FasBashLib
sudo make install
```

To uninstall it, please run it.

```bash
git clone https://github.com/Hayao0819/FasBashLib.git
cd FasBashLib
sudo make uninstall
```

## Stable library Offline without install

See [Release Page](https://github.com/Hayao0819/FasBashLib/releases) and download `fasbashlib.sh`


## The latest dev library Online

Add this line into your script. You should connect to the Internet.

```bash
source /dev/stdin < <(curl -sL "https://raw.githubusercontent.com/Hayao0819/FasBashLib/build-0.2.x/fasbashlib.sh")
```

## The latest dev library Offline

Clone this repository and build it. See [Build documemt](./BUILD.md)

## Git submodule in your project

Add this repository as submodule

```bash
git submodule add https://github.com/Hayao0819/FasBashLib.git fasbashlib
cd ./fasbashlib/
git checkout build-0.2.x
cd ../
git commit -m 'Add FasBashLib as a submodule'
```
The build-0.2.x branch contains scripts built with GitHub Actions.

```bash
source ./fasbashlib/fasbashlib.sh
```

When you want to update library version, checkout to the latest commit in the submodule.
