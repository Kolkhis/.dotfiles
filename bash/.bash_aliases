alias cls="clear"
alias path="printf \"${PATH//:/\\n}\""
alias ?="duck"
alias ??="gpt"
alias aoc="cd ~/.dotfiles/coding/coding/advent_of_code/"

set -o vi
export EDITOR=vi
# export TERM=xterm-256color
force_color_prompt=yes
GPG_TTY=$(tty)
export GPG_TTY
