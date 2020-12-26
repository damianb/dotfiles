export EDITOR=nano # fuck you all, emacs and vim just take too much twister
# set PS1, depends on git...
if [ -x ~/.git-prompt.sh ]; then
	source ~/.git-prompt.sh
	export GIT_PS1_SHOWDIRTYSTATE=1
	export GIT_PS1_SHOWUNTRACKEDFILES=1
	export GIT_PS1_SHOWUPSTREAM="auto"
	if [ $UID -eq 0 ]; then
		export PS1="\[\e[32;1m\]:\[\e[0m\]\[\e[37;1m\]\u\[\e[37;1m\]@\h \[\e[34;1m\]\w/ \n\[\e[33m\]\$(__git_ps1 '(%s) ')\[\e[0m\]\[\e[31m\]#\[\e[0m\] "
	else
		export PS1="\[\e[32;1m\]:\[\e[0m\]\[\e[37;1m\]\u\[\e[37;1m\]@\h \[\e[34;1m\]\w/ \n\[\e[33m\]\$(__git_ps1 '(%s) ')\[\e[0m\]\[\e[32m\]\$\[\e[0m\] "
	fi
else
	if [ $UID -eq 0 ]; then
		export PS1="\[\e[32;1m\]:\[\e[0m\]\[\e[37;1m\]\u\[\e[37;1m\]@\h \[\e[34;1m\]\w/ \n\[\e[33m\]\[\e[0m\]\[\e[31m\]#\[\e[0m\] "
	else
		export PS1="\[\e[32;1m\]:\[\e[0m\]\[\e[37;1m\]\u\[\e[37;1m\]@\h \[\e[34;1m\]\w/ \n\[\e[33m\]\[\e[0m\]\[\e[32m\]\$\[\e[0m\] "
	fi
fi

[ -x /etc/profile.d/autojump.bash ] && source /etc/profile.d/autojump.bash

# general aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll="ls -lAFh"
function mkdircd() { mkdir $1; cd $1; }
alias mkc=mkdircd
alias listps='ps aux | grep -v "ps aux" | grep -Ev "\[.+\]" | grep -v grep'
alias memoryhog="ps aux | sort -nk +4 | tail -n 20"
function sizehog() { du -hd 1 $@ | sort -h | tail -n 21 | head -n 20; }
alias du="du -h"
alias df="df -h"
alias netconnections="netstat -tuapw --numeric-hosts --numeric-ports"
alias ts="date +%s"
[ -x /usr/bin/systemctl ] && alias sys="systemctl" # a symlink in /usr/bin works better to be honest
[ -x /usr/bin/htop ] && alias top=htop

if [ "$PS1" ]; then
    complete -cf sudo
fi

# git aliases
alias gs="git status"
alias ga="git add"
alias gp="git push"
alias gg="git pull"
