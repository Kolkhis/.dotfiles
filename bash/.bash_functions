#!/bin/bash


getcolor() {
    printf "\e[38;5;%smThis is the 255-color repr of $1\n" "$1" 
}


RESET="\[\e[0m\]"
parse_git_branch() {
    branch="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')"
    printf "%s${branch}%s" "" "${RESET}"
}


check_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv_name=$(basename "$VIRTUAL_ENV")
        printf "(%s) " "${venv_name}"
    fi
}


get_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


shopts() {
    PAGER='less "+/^ *The list of shopt"' man bash
}


goto() {
    p=$(which "$1")
    d=$(dirname "$p")
    printf "Going to %s. \n" "$d"
    cd "$d" || exit
}


mc() {
    declare OPENAI_API_KEY
    OPENAI_API_KEY="$(head -1 "$HOME/.config/gpt/token")"
    export OPENAI_API_KEY
    if test -t 0; then
      if _have glow; then
        mods -C --status-text "Ummm" -f "$*" | glow
      else
        mods -C --status-text "Ummm" "$*"
      fi
    else
      mods -C --quiet "$*" | sed 's,[?25l [0D[2K[?25h[?1002l[?1003l,,g'
      # |sed 's/\x1B\[[0-9;\?]*[a-zA-Z]//g'
    fi
}



