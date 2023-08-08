export EDITOR=nano

PROMPT_COMMAND=__prompt_command
__prompt_command() {
    local EXIT="$?"

    PS1='\[\e]0;$PWD\007\]'     # set window title
    PS1+='\n'                   # new line
    if [ $EXIT -eq 1 ]; then    # in the event of an error...
        PS1+='\[\e[31m\]'       # change to red
    else                        # otherwise...
        PS1+='\[\e[90m\]'        # change to gray
    fi

    PS1+='::'                   # error indicator
    PS1+='\[\e[33;1m\]'         # change to yellow
    PS1+=' ['                   # open bracket
    PS1+='\[\e[0;1m\]'          # change to white
    PS1+='\u@\h'                # user@host<space>
    PS1+='\[\e[33;1m\]'         # change to yellow
    PS1+='] '                   # close bracket
    PS1+='\[\e[34;1m\]'         # change to blue
    PS1+='\w'                   # current working directory
    PS1+='\[\e[0m\]'            # reset color
    if test -z "$WINELOADERNOEXEC"
    then
        #GIT_PS1_SHOWDIRTYSTATE=1
        #GIT_PS1_SHOWUNTRACKEDFILES=1
        #GIT_PS1_SHOWUPSTREAM="auto"
        GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
        COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
        COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
        COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
        if test -f "$COMPLETION_PATH/git-prompt.sh"; then
            . "$COMPLETION_PATH/git-completion.bash"
            . "$COMPLETION_PATH/git-prompt.sh"
            PS1+='\[\e[33m\]'   # change to yellow
            PS1+='`__git_ps1`'  # bash function
        fi
    fi
    PS1+='\n'                   # new line

    if [ $UID -eq 0 ]; then
        PS1+='\[\e[31m\]'       # change to red
        PS1+='# '               # prompt: use # for root
    else
        PS1+='\[\e[32m\]'       # change to green
        PS1+='$ '               # prompt: use $ for users
    fi

    PS1+='\[\e[0m\]'            # reset color
    export PS1

    MSYS2_PS1="$PS1"            # for detection by MSYS2 SDK's bash.basrc
}

# general aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll="ls -lAFh"
function mkdircd() { mkdir "$1" && cd "$1"; }
alias mkc=mkdircd
alias listps='ps aux | grep -v "ps aux" | grep -Ev "\[.+\]" | grep -v grep'
alias memoryhog="ps aux | sort -nk +4 | tail -n 20"
function sizehog() { du -hd 1 "$@" | sort -h | tail -n 21 | head -n 20; }
alias du="du -h"
alias df="df -h"
alias netconnections="netstat -tuapwn"
alias ts="date +%s"
[ -x /usr/bin/systemctl ] && alias sys="systemctl" # a symlink in /usr/bin works better to be honest

if [ "$PS1" ]; then
    complete -cf sudo
fi

# git aliases
alias gs="git status"
alias ga="git add"
alias gp="git push"
alias gg="git pull"
