#!/bin/bash
function ctext {
  printf "%*s\n" $(( (${#1} + "$(tput cols)") / 2)) "$1"
}
function hline {
  printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " $1
}
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[94m"
ENDCOLOR="\e[0m"
RESET="\033[0K\r"
UNDERLINE="\e[4m"