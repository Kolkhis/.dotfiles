# shellcheck disable=SC2059,SC1091,SC1090
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    if [ -r ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

################################## Env ################################## 
# Node Version Manager 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

# Crablang (Rust)
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"

# Set XDG_CONFIG_HOME/DATA if it's unset
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="${HOME}/.config"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="${HOME}/.local/share"

export FZF_DEFAULT_COMMAND='find . -type f ! -path "*/.git/*"'
export FZF_DEFAULT_OPTS="\
--tabstop=4 \
--preview 'cat {}' \
--preview-window 'right,50%,border-rounded' \
--bind '?:preview:file {}' \
--bind 'change:first' \
--bind 'enter:execute(nvim {})' \
--bind 'ctrl-d:preview-page-down' \
--bind 'ctrl-l:forward-char' \
--bind 'ctrl-h:backward-char' \
--bind 'ctrl-f:preview-down' \
--bind 'ctrl-b:preview-up' \
--bind 'ctrl-u:clear-query' \
--bind 'ctrl-w:backward-kill-word' \
--bind 'ctrl-\\:change-preview-window(bottom,70%,border-rounded|hidden|)' \
"

declare SRC_ENDPOINT
declare SRC_ACCESS_TOKEN
SRC_ENDPOINT="$(head -1 "$HOME/.config/cody/endpoint")"
SRC_ACCESS_TOKEN="$(head -1 "$HOME/.config/cody/token")"
export SRC_ENDPOINT
export SRC_ACCESS_TOKEN

# 38;5;0 - 255 : 88/256-color foreground colors.  
# 48;5;0 - 255 : 88/256-color background colors.  
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GREP_COLORS=':ms=01;31:mc=01;31:sl=38;5;248:cx=38;5;244:fn=38;5;68:ln=38;5;81:bn=32:se=36' 
eval "$(dircolors -b ~/.dircolors)"


################################## PS1 ################################## 
# Python: Prevent default "(venv)" text
export VIRTUAL_ENV_DISABLE_PROMPT=1
YELLOW='\[\e[38;5;214m\]'
BURNT_ORANGE='\[\e[38;5;130m\]'
DARK_YELLOW="\[\e[38;5;58m\]"
GREY='\[\e[38;5;241m\]'
MUTED_BLUEGREEN="\[\e[38;5;30m\]"
RED_256="\[\e[38;5;160m\]"
RESET="\[\e[0m\]"
LIGHT_PURPLE="\[\e[38;5;99m\]"
SOFT_PINK="\[\e[38;5;212m\]"
# LIGHT_BLUE="\[\e[38;5;81m\]"
# SOFT_BLUE="\[\e[38;5;111m\]"
# BEIGE='\[\e[38;5;180m\]'
# SOFT_PURPLE="\[\e[38;5;61m\]"
DARK_RED="\[\e[38;5;88m\]"
SEP_COLOR=${DARK_RED}
FIRST_SEP="┎"   # ┎┏┍ ┏ ┒ ┒┎ ┏ ┍
SECOND_SEP="┖"  # ┖┗┕ ┖ ┚ ┨┠ ┣ ┝ ┫┠
                #         ┚┖ ┗ ┕
case $USER in
    (root)
        NAME_COLOR=${RED_256};
        HOST_COLOR=${BURNT_ORANGE};
        PATH_COLOR=${LIGHT_PURPLE};
        VENV_COLOR=${SOFT_PINK}
	;;
    (*)
        NAME_COLOR=${DARK_YELLOW};
        HOST_COLOR=${BURNT_ORANGE};
        PATH_COLOR=${MUTED_BLUEGREEN};
        VENV_COLOR=${YELLOW}
	;;
esac

set_prompt() {
    if echo "$ORIGINAL_PATH" | grep 'cyg' > /dev/null 2>&1; then
        SEP_COLOR="\[\e[38;5;95m\]";
        NAME_COLOR="\[\e[38;5;61m\]";
        PATH_COLOR="\[\e[38;5;24m\]";
    else
        SEP_COLOR="\[\e[38;5;88m\]";
    fi
    PS1=\
"${SEP_COLOR}${FIRST_SEP} \
${NAME_COLOR}\
\u${GREY}@\
${HOST_COLOR}\
\h${GREY}:\
${PATH_COLOR}\
\$(pwd_shortened)\
${RED_256}\
\$(get_git_branch)\
\n${SEP_COLOR}${SECOND_SEP} \
${VENV_COLOR}\$(check_venv)\
${GREY}\\$ ${RESET}"
}
# \W\

# pwd_shortened:  sed -E 's/.*\/(.*\/.*$)/\1/' 2>/dev/null
# different prompt for git bash
case $(hostname) in
    ("D01")
        if echo "$ORIGINAL_PATH" | grep mingw > /dev/null 2>&1; then
            source /etc/profile.d/git-prompt.sh;
        else
            set_prompt;
        fi
        ;;
    (*)
        set_prompt;
        ;;
esac
export PS1
export PS2="${GREY}~>${RESET} "
