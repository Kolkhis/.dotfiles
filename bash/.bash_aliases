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
alias pythong="python3"
alias vi="\$(which vim)";
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
# Make tmux use XDG_CONFIG_HOME
alias tmux='tmux -f "${XDG_CONFIG_HOME}/tmux/.tmux.conf"'
# Git aliases
alias gits="git status"

# Navigation
alias dots="cd ~/.dotfiles/"
alias aoc="cd ~/Repos/github.com/kolkhis/aoc-2023/"
alias nv="cd ~/.dotfiles/nvim/.config/nvim/"
alias v="cd ~/.dotfiles/vim"
alias boost="cd ~/notes/skilstak/" 
alias rp="cd ~/Repos/github.com/kolkhis/"
alias s="cd ~/.dotfiles/scripts/.local/bin/"
alias n="cd ~/notes/"
alias ta="cd ~/Repos/github.com/kolkhis/taggart"
alias tw="cd ~/Repos/github.com/kolkhis/twitch_chat_bot/"
alias gl="cd ~/Repos/github.com/kolkhis/go-fundamentals/"
alias db="cd ~/Repos/github.com/kolkhis/discord_bot/"

case $(hostname) in
    ("D01")
        alias nv="cd ~/AppData/Local/nvim";
        ;;
    (*)
        alias nv="cd ~/.dotfiles/nvim/.config/nvim/";
        ;;
esac

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands. E.g.: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Using vim/neovim as `less`
export VRT="/usr/share/vim/vim82"
alias vless="\${VRT}/macros/less.sh"
export NVRT="/usr/share/nvim/runtime/"
alias nvl="\${NVRT}/macros/less.sh"

