alias cls="clear"
alias path="printf \"${PATH//:/\\n}\""
alias ?="duck"
alias ??="gpt"
alias aoc="cd ~/.dotfiles/coding/coding/advent_of_code/"
alias py="python3"
alias python="python3"
alias dots="cd ~/.dotfiles/"
alias clsa='printf "\e[H\e[2J"'

# godmode
set -o vi

export EDITOR=nvim
# export TERM=xterm-256color
force_color_prompt=yes
GPG_TTY=$(tty)
export GPG_TTY

parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[1;34m\]\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
export PATH=~/bin:$PATH

