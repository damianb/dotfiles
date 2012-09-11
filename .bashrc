export EDITOR=nano
source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
export PS1="\[`if [[ $? = 0 ]]; then echo '\[\e[32;1m\]:\[\e[0m\]'; else echo '\[\e[31;1m\]:\[\e[0m\]' ; fi`\[\e[37;1m\]\u\[\e[37;1m\]@\h \[\e[34;1m\]\w/ \n\[\e[33m\]\$(__git_ps1 '(%s) ')\[\e[0m\]\[\e[32m\]\$\[\e[0m\] "

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll="ls -lAFh"

# push script aliases
alias irc="TERM=xterm;ssh -t sabros /home/katana/scripts/weechat.sh"
alias push="/home/katana/push.sh"
alias pushscreen="/home/katana/push.sh -s"
alias pushfile="/home/katana/push.sh -u"
alias steam='WINEDEBUG=-all wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe >/dev/null 2>&1 &'
alias listps='ps aux | grep -v "ps aux" | grep -Ev "\[.+\]" | grep -v grep'
