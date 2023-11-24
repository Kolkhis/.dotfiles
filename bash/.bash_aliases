# shellcheck shell=bash
# shellcheck disable=SC2059,SC1091

alias cls='printf "\e[H\e[2J"'
alias c='clear'
alias path='printf "${PATH//:/\\n}"'
# Search with DuckDuckGo
alias "?"="duck"

# Use charmbracelet/mods to talk to ChatGPT
alias "??"="gpt"
alias py="python3"
alias python="python3"
alias vi="/usr/local/bin/vim"
alias vim="nvim"
alias lv="vim -c \"normal '0\""
alias vl="vi -c \"normal '0\""
alias clsa='printf "\e[H\e[2J"'

# Auto-flags
alias ls='ls --color=auto --classify'
alias ll='ls --color=auto --classify --almost-all -l --human-readable' # ls -CFAlh
alias l='ll'
alias cal="ncal -b"
alias tree="tree -a"
alias ip="ip -color"

# Navigation
alias dots="cd ~/.dotfiles/"
alias aoc="cd ~/.dotfiles/coding/coding/advent_of_code/"
alias nv="cd ~/.dotfiles/nvim/.config/nvim/"  
alias v="cd ~/.dotfiles/vim"
alias boost="cd ~/notes/skilstak/" 
alias rp="cd ~/Repos/github.com/kolkhis/"
alias s="cd ~/.dotfiles/scripts/.local/bin/"
alias n="cd ~/notes/"
alias ta="cd ~/Repos/github.com/kolkhis/taggart"
alias tw="cd ~/Repos/github.com/kolkhis/twitch_chat_bot/"

# Git aliases
alias gits="git status"

# Using vim/neovim as `less`
export VRT="/usr/share/vim/vim82"
alias vless="\${VRT}/macros/less.sh"
export NVRT="/usr/share/nvim/runtime/"
alias nvl="\${NVRT}/macros/less.sh"

# godmode
set -o vi

# Allow ** for recursive searching and pattern matching
shopt -s globstar

# Include dotfiles in pathname expansion
shopt -s dotglob
shopt -s nocaseglob

#extdebug
#force_fignore

# set timezone
export TZ="America/New_York"
export TERM=xterm-256color
export NOTES_HOME="/home/kolkhis/notes"
export LC_ALL=C.UTF-8
export EDITOR=nvim
export PATH=~/bin:$PATH
export force_color_prompt=yes
export COLUMNS=120 LINES=30
GPG_TTY=$(tty)
export GPG_TTY

export PATH=$PATH:/usr/local/go/bin
export CGO_ENABLED=0
export GO111MODULE=on

