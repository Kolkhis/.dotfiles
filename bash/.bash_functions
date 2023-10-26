#!/bin/bash


getcolor() {
    printf "\e[38;5;%smThis is the 255-color repr of $1\n" "$1" 
}

RESET="\[\e[0m\]"
parse_git_branch() {
    branch="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')"
    printf "%s${branch}%s" "" "${RESET}"
}

get_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

shopts() {
    PAGER='less "+/^ *The list of shopt"' man bash
}


