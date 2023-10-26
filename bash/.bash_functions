#!/bin/bash




# Extra escapes needed for `echo` and the `%s` formatting with `printf`
# YELLOW="\[\e[33m\]" 
# YELLOW="\[\e[33m\]"
# GREEN="\[\e[32m\]"
# CYAN="\[\e[36m\]"
# RED="\[\e[31m\]"
# BLUE="\[\e[34m\]"
# MAGENTA="\[\e[35m\]"
# WHITE="\[\e[37m\]"

get_color() {
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


