#!/usr/bin/env bash

GetMkinitcpioPresetList(){
    find "/etc/mkinitcpio.d/" -name "*.preset" -type f | GetBaseName | RemoveFileExt
}

GetKernelFileList(){
    find "/boot" -maxdepth 1 -mindepth 1 -name "vmlinuz-*"
}

GetKernelSrcList(){
    find "/usr/src" -mindepth 1 -maxdepth 1 -type l -name "linux*"
}
