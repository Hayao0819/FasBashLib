#!/bin/sh

ClearScreen(){
    printf "\033[2J"
}

ClearRight(){
    printf "\033[0K"
}

ClearLeft(){
    printf "\033[1K"
}

ClearLine(){
    printf "\033[2K"
}
