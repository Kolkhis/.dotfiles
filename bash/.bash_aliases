alias cls="clear"
alias path="printf \"${PATH//:/\\n}\""
alias ?="duck"
alias ??="gpt"
alias aoc="cd ~/.dotfiles/coding/coding/advent_of_code/"
alias py="python3"
alias python="python3"

# godmode
set -o vi

export EDITOR=nvim
# export TERM=xterm-256color
force_color_prompt=yes
GPG_TTY=$(tty)
export GPG_TTY

