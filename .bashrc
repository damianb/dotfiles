export EDITOR=nano
# set PS1, depends on git...
if [ -x ~/.git-prompt.sh ]; then
	source ~/.git-prompt.sh
	export GIT_PS1_SHOWDIRTYSTATE=1
	export GIT_PS1_SHOWUNTRACKEDFILES=1
	export GIT_PS1_SHOWUPSTREAM="auto"
	export PS1="\[\e[32;1m\]:\[\e[0m\]\[\e[37;1m\]\u\[\e[37;1m\]@\h \[\e[34;1m\]\w/ \n\[\e[33m\]\$(__git_ps1 '(%s) ')\[\e[0m\]\[\e[32m\]\$\[\e[0m\] "
else
	export PS1="\[\e[32;1m\]:\[\e[0m\]\[\e[37;1m\]\u\[\e[37;1m\]@\h \[\e[34;1m\]\w/ \n\[\e[33m\]\[\e[0m\]\[\e[32m\]\$\[\e[0m\] "
fi

[ -x /etc/profile.d/autojump.bash ] && source /etc/profile.d/autojump.bash

# general aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll="ls -lAFh"
function mkdircd() { mkdir $1; cd $1; }
alias mkc=mkdircd
alias irc="TERM=xterm;ssh -t serenity /home/katana/scripts/weechat.sh"
alias listps='ps aux | grep -v "ps aux" | grep -Ev "\[.+\]" | grep -v grep'
alias memoryhog="ps aux | sort -nk +4 | tail"
alias ts="date +%s"
[ -x /usr/bin/systemctl ] && sys="systemctl"
[ -x /usr/bin/htop ] && alias top=htop

# git aliases
alias gs="git status"
alias ga="git add"
alias gp="git push"
alias compile="g++"
alias gg="git pull"
# this makes it so we can use bare words with the git commit message...less functionality, but easier.
function gitcommit {
	m=$@
	m=$(printf " %s" "${m[@]}")
        m=${m:1}
        git commit -m "$m"
}
alias gc=gitcommit

if [ "$PS1" ]; then
    complete -cf sudo
fi

# easy extract, nabbed from reddit.
extract () {
  if [ -f "$1" ] ; then
    case "$1" in
        *.tar.bz2)   tar xvjf "$1"    ;;
        *.tar.gz)    tar xvzf "$1"    ;;
        *.bz2)       bunzip2 "$1"     ;;
        *.rar)       rar x "$1"       ;;
        *.gz)        gunzip "$1"      ;;
        *.tar)       tar xvf "$1"     ;;
        *.tbz2)      tar xvjf "$1"    ;;
        *.tgz)       tar xvzf "$1"    ;;
        *.zip)       unzip "$1"       ;;
        *.Z)         uncompress "$1"  ;;
        *.7z)        7z x "$1"        ;;
        *)           echo "don't know how to extract '$1'..." ;;
    esac
else
    echo "'$1' is not a valid file!"
fi
}
alias ex=extract
