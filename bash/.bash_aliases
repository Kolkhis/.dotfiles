# shellcheck shell=bash
# shellcheck disable=SC2059

alias cls='printf "\e[H\e[2J"'
alias c='clear'
alias path='printf "${PATH//:/\\n}"'
# Search with DuckDuckGo
alias "?"="duck"

# Use charmbracelet/mods to talk to ChatGPT
alias "??"="gpt"
alias py="python3"
alias python="python3"
alias clsa='printf "\e[H\e[2J"'

# Auto-flags
alias ls='ls --color=auto --classify'
alias ll='ls --color=auto --classify --almost-all -l --human-readable' # ls -CFAlh
alias l='ll' # ls -CFAlh
alias cal="ncal -b"
alias tree="tree -a"
alias ip="ip -color"

# Navigation
alias dots="cd ~/.dotfiles/"
alias aoc="cd ~/.dotfiles/coding/coding/advent_of_code/"
alias nv="cd ~/.dotfiles/nvim/.config/nvim/"  
alias boost="cd ~/notes/skilstak/" 
alias rp="cd ~/Repos/github.com/kolkhis/"
alias s="cd ~/.dotfiles/scripts/.local/bin/"
alias n="cd ~/notes/"

# Using vim/neovim as `less`
export VRT="/usr/share/vim/vim82"
alias vless="\${VRT}/macros/less.sh"
export NVRT="/usr/share/nvim/runtime/"
alias nvl="\${NVRT}/macros/less.sh"

# godmode
set -o vi

# Allow ** for recursive matches ('lib/**/*.rb' => 'lib/a/b/c.rb')
shopt -s globstar

# Include dotfiles in pathname expansion
shopt -s dotglob
shopt -s nocaseglob

#extdebug
#force_fignore


export VRT="/usr/share/vim/vim82"
export NOTES_HOME="/home/kolkhis/notes"
export LC_ALL=C.UTF-8
export EDITOR=nvim
export PATH=~/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export CGO_ENABLED=0
export GO111MODULE=on
export TERM=xterm-256color
COLUMNS=120
LINES=30
export COLUMNS LINES
export force_color_prompt=yes
GPG_TTY=$(tty)
export GPG_TTY


BURNT_ORANGE='\[\e[38;5;130m\]' # 130 172 166
DARK_YELLOW="\[\e[38;5;58m\]"
GREY='\[\e[38;5;241m\]'
MUTED_BLUEGREEN="\[\e[38;5;30m\]"
RED_256="\[\e[38;5;160m\]"
RESET="\[\e[0m\]"
LIGHT_PURPLE="\[\e[38;5;99m\]"
SOFT_BLUE="\[\e[38;5;81m\]"

# NAME_COLOR=${DARK_YELLOW}
# HOST_COLOR=${BURNT_ORANGE}
# PATH_COLOR=${MUTED_BLUEGREEN}

case $USER in
    (root)
        NAME_COLOR=${RED_256};
        HOST_COLOR=${BURNT_ORANGE};
        PATH_COLOR=${LIGHT_PURPLE}
	;;
    (*)
        NAME_COLOR=${DARK_YELLOW};
        HOST_COLOR=${BURNT_ORANGE};
        PATH_COLOR=${MUTED_BLUEGREEN}
	;;
esac

# 88
DARK_RED="\[\e[38;5;88m\]"
SEP_COLOR=${DARK_RED}
FIRST_SEP="┎" # ┎┏┍
SECOND_SEP="┖" #┖┗┕
export PS1=\
"${SEP_COLOR}${FIRST_SEP} \
${NAME_COLOR}\
\u${GREY}@\
${HOST_COLOR}\
\h${GREY}:\
${PATH_COLOR}\
\w\
${RED_256}\
\$(get_git_branch)\
\n${SEP_COLOR}${SECOND_SEP}\
${GREY} \\$ ${RESET}"
# ┏
# ┖
export PS2="${RED_256}~> "



# $(uptime | awk '{print $10}')
# 2:03:58
eval "$(dircolors -b ~/.dircolors)"
