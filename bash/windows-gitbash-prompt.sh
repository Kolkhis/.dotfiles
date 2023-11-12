# For Git Bash on Windows
# goes in ~/.config/git/git-prompt.sh
if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

BURNT_ORANGE='\[\e[38;5;130m\]'
DARK_YELLOW="\[\e[38;5;58m\]"
GREY='\[\e[38;5;241m\]'
MUTED_BLUEGREEN="\[\e[38;5;30m\]"
RED_256="\[\e[38;5;160m\]"
RESET="\[\e[0m\]"
LIGHT_PURPLE="\[\e[38;5;99m\]"

DARK_RED="\[\e[38;5;88m\]"
SEP_COLOR=${DARK_RED}
FIRST_SEP="┎"   # ┎┏┍ ┏ ┒ ┒┎ ┏ ┍
SECOND_SEP="┖"  # ┖┗┕ ┖ ┚ ┨┠ ┣ ┝ ┫┠
                #         ┚┖ ┗ ┕

PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
PS1="$PS1"'\n\[\e[38;5;88m\]'   # sep color
PS1="$PS1"'┎ '
PS1="$PS1"'\[\e[38;5;58m\]'     # name color
PS1="$PS1"'\u'
PS1="$PS1"'\[\e[38;5;241m\]@\[\e[38;5;130m\]'
PS1="$PS1"'\h'
PS1="$PS1"'\[\e[38;5;241m\]'    # : color
PS1="$PS1"':'
PS1="$PS1"'\[\e[38;5;30m\]'     # path color
PS1="$PS1"'\w'                 # current working directory
if test -z "$WINELOADERNOEXEC"
then
        GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
        COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
        COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
        COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
        if test -f "$COMPLETION_PATH/git-prompt.sh"
        then
                . "$COMPLETION_PATH/git-completion.bash"
                . "$COMPLETION_PATH/git-prompt.sh"
                PS1="$PS1"'\[\e[38;5;88m\]'  # change color to cyan
                PS1="$PS1"'`__git_ps1`'   # bash function
        fi
fi
PS1="$PS1"'\[\e[38;5;88m\]'        # change color
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'┖ '
PS1="$PS1"'\[\e[38;5;241m\]'
PS1="$PS1"'$ '                 # prompt: always $
PS1="$PS1"'\[\e[0m\]'

MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc

# Evaluate all user-specific Bash completion scripts (if any)
if test -z "$WINELOADERNOEXEC"
then
	for c in "$HOME"/bash_completion.d/*.bash
	do
		# Handle absence of any scripts (or the folder) gracefully
		test ! -f "$c" ||
		. "$c"
	done
fi
