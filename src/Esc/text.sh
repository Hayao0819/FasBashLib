#!/bin/sh

ResetStyle(){
    printf "\033[0m" > /dev/tty
}

BlackText(){
    printf "\033[30m" > /dev/tty
}

RedText(){
    printf "\033[31m" > /dev/tty
}

GreenText(){
    printf "\033[32m" > /dev/tty
}

YellowText(){
    printf "\033[33m" > /dev/tty
}

BlueText(){
    printf "\033[34m" > /dev/tty
}

MagentaText(){
    printf "\033[35m" > /dev/tty
}

CyanText(){
    printf "\033[36m" > /dev/tty
}

WhiteText(){
    printf "\033[37m" > /dev/tty
}

BlackBackground(){
    printf "\033[40m" > /dev/tty
}

RedBackground(){
    printf "\033[41m" > /dev/tty
}

GreenBackground(){
    printf "\033[42m" > /dev/tty
}

YellowBackground(){
    printf "\033[43m" > /dev/tty
}

BlueBackground(){
    printf "\033[44m" > /dev/tty
}

MagentaBackground(){
    printf "\033[45m" > /dev/tty
}

CyanBackground(){
    printf "\033[46m" > /dev/tty
}

WhiteBackground(){
    printf "\033[47m" > /dev/tty
}

Bold(){
    printf "\033[1m" > /dev/tty
}

LowIntensity(){
    printf "\033[2m" > /dev/tty
}

Italic(){
    printf "\033[3m" > /dev/tty
}

Underline(){
    printf "\033[4m" > /dev/tty
}

Blink(){
    printf "\033[5m" > /dev/tty
}

RapidBlink(){
    printf "\033[6m" > /dev/tty
}

Reverse(){
    printf "\033[7m" > /dev/tty
}

Conceal(){
    printf "\033[8m" > /dev/tty
}

CrossedOut(){
    printf "\033[9m" > /dev/tty
}


