#!/bin/sh

ClearScreen(){
    printf "\033[2J" > /dev/tty
}

ClearRight(){
    printf "\033[0K" > /dev/tty
}

ClearLeft(){
    printf "\033[1K" > /dev/tty
}

ClearLine(){
    printf "\033[2K" > /dev/tty
}

Return(){
    printf "\r" > /dev/tty
}
