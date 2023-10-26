
# shellcheck shell=bash
# shellcheck disable=SC2059

alias cls="clear"
alias path='printf "${PATH//:/\\n}"'
# Search with DuckDuckGo
alias "?"="duck"

# Use charmbracelet/mods to talk to ChatGPT
alias "??"="gpt"
alias aoc="cd ~/.dotfiles/coding/coding/advent_of_code/"
alias py="python3"
alias python="python3"
alias dots="cd ~/.dotfiles/"
alias clsa='printf "\e[H\e[2J"'
alias nv="cd ~/.dotfiles/nvim/.config/nvim/"
alias boost="cd ~/.dotfiles/notes/notes/skilstak/"

# godmode
set -o vi

RESET="\[\033[0m\]"
BOLD="\[\033[1m\]"
UNDERLINE="\[\033[4m\]"

YELLOW="\[\033[33m\]"
RED="\[\033[31m\]"
GREEN="\[\033[32m\]"
BLUE="\[\033[34m\]"
MAGENTA="\[\033[35m\]"
CYAN="\[\033[36m\]"
WHITE="\[\033[37m\]"

export EDITOR=nvim
export PATH=~/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export TERM=xterm-256color
export force_color_prompt=yes
GPG_TTY=$(tty)
export GPG_TTY

parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    # branch="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')"
    # printf "$branch"
    # printf "$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')"
}

# Customize prompt
export PS1=\
"${GREEN}\
\u@\h \
${CYAN}\
\w\
${YELLOW}\
\$(parse_git_branch)\
${RESET} $ "

# $(uptime | awk '{print $10}')
# 2:03:58
