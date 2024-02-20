#!/bin/bash

getcolor() {
    if [[ -z "$1" || "$1" -gt 255 || "$1" -lt 0 ]]; then
        printf "You need to provide a number 0-255\n"
        return
    fi
    black_text=$'\e[38;5;232m'
    white_text=$'\e[38;5;255m'
    black_bg=$'\e[48;5;232m'
    white_bg=$'\e[48;5;255m'
    r=$'\e[0m'
    printf "\e[38;5;%smThis is the foreground 255-color repr of $1%s\n" "$1" "$r"
    printf "%s\e[38;5;%smThis is the foreground 255-color repr of $1%s\n" "$black_bg" "$1" "$r"
    printf "%s\e[38;5;%smThis is the foreground 255-color repr of $1%s\n" "$white_bg" "$1" "$r"
    printf "%s\e[48;5;%smThis is the background 255-color repr of $1%s\n" "$black_text" "$1" "$r"
    printf "%s\e[48;5;%smThis is the background 255-color repr of $1%s\n" "$white_text" "$1" "$r"
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

standardcolor() {
    for i in {0..7}; do
        c=$'\e[3'${i}'m'
        printf "%sColor Code: %s\n" "$c" "$i"
    done
}

goto() {
    d="$(dirname "$(which "$1")")"
    printf "Going to %s. \n" "$d" && cd "$d" || return 1
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

pwd_shortened() {
    # pwd | sed -E 's/.*\/(.*\/.*$)/\1/' 2>/dev/null
    pwd | sed -E "s;^$HOME;~;" 2>/dev/null | sed -E 's;.*/(.*/.*$);\1;' 2>/dev/null
}

read_hide() {
    while [[ -n "$1" ]]; do
        case $1 in
            (-p|--prompt)
                shift;
                PROMPT="$1"
                shift;
                ;;
            (-h|--hide|--hide-all)
                HIDE_ALL=true;
                shift;
                ;;
            (*)
                PROMPT="$1"
                shift;
                ;;
        esac
    done
    [[ -z "$PROMPT" ]] && PROMPT="Input: "
    printf "%s" "$PROMPT"
    unset INPUT
    if [[ -z "$HIDE_ALL" ]]; then
        while IFS= read -r -s -n1 KEYPRESS; do
            # KEYPRESS is empty when the user hits enter
            if [[ -z $KEYPRESS ]]; then
                printf "\n"
                break
            elif [[ $KEYPRESS == $'\x7f' ]] || [[ $KEYPRESS == $'\x08' ]]; then
                if [[ -n $INPUT ]]; then
                    printf "\b \b"
                    INPUT=${INPUT:0:$((${#INPUT} - 1))}
                fi
            else
                printf "*"
                INPUT+=$KEYPRESS
            fi
        done
        printf "%s" "$INPUT" 2>/dev/null
    else
        stty_original=$(stty -g)
        stty -echo
        read -r INPUT
        stty "$stty_original"
        printf "%s" "$INPUT" 2>/dev/null
    fi
}

