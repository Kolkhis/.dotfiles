# shellcheck shell=bash
# shellcheck disable=SC2059

alias cls='printf "\e[H\e[2J"'
alias path='printf "${PATH//:/\\n}"'
# Search with DuckDuckGo
alias "?"="duck"

# Use charmbracelet/mods to talk to ChatGPT
alias "??"="gpt"
alias py="python3"
alias python="python3"
alias clsa='printf "\e[H\e[2J"'
alias cal="ncal -b"

# Navigation
alias dots="cd ~/.dotfiles/"
alias aoc="cd ~/.dotfiles/coding/coding/advent_of_code/"
alias nv="cd ~/.dotfiles/nvim/.config/nvim/"  
alias boost="cd ~/.dotfiles/notes/notes/skilstak/" 
alias rp="cd ~/Repos/github.com/kolkhis/"
alias s="cd ~/.dotfiles/scripts/.local/bin/"
# godmode
set -o vi

# Allow ** for recursive matches ('lib/**/*.rb' => 'lib/a/b/c.rb')
shopt -s globstar

shopt -s dotglob
shopt -s nocaseglob

export NOTES_HOME="/home/kolkhis/notes"
export LC_ALL=C.UTF-8
export EDITOR=nvim
export PATH=~/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export TERM=xterm-256color
export force_color_prompt=yes
GPG_TTY=$(tty)
export GPG_TTY

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

BLACK=$'\e[30m'
RESET="\[\033[0m\]"
BOLD="\[\033[1m\]"
UNDERLINE="\[\033[4m\]"

get_git_branch() {
    branch="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')"
    printf "${branch}${RESET}"
}

export LIGHT_BLUE="\e[38;5;68m"

# BASH Base Colors:
export BLACK=$'\e[30m'
export RED=$'\e[31m'
export GREEN=$'\e[32m'
export YELLOW=$'\e[33m'
export BLUE=$'\e[34m'
export MAGENTA=$'\e[35m'
export CYAN=$'\e[36m'
export WHITE=$'\e[37m'


export RESET=$'\e[0m'
export BOLD=$'\e[1m'
export UNDERLINE=$'\e[4m'

export BURNT_ORANGE='\e[38;5;130m' # 130 172 166
export DARK_YELLOW="\e[38;5;58m"
export GREY='\e[38;5;241m'
export MUTED_BLUEGREEN="\e[38;5;30m"
export RED_256="\e[38;5;160m"
# Customize prompt
export PS1=\
"${DARK_YELLOW}\
\u${RESET}${GREY}@\
${RESET}${BURNT_ORANGE}\
\h${RESET}${GREY}:${RESET}\
${MUTED_BLUEGREEN}\
\w\
${RESET}${RED_256}\
\$(parse_git_branch)\
 ${RESET}${GREY}\$${RESET} "

# $(uptime | awk '{print $10}')
# 2:03:58
eval "$(dircolors -b ~/.dircolors)"



