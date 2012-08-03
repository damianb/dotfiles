alias ls='ls --color=auto'

if ! { [ -n "$TMUX" ]; } then
	#PS1="@$HOSTNAME $PS1"
	[ ! "$UID" = "0" ] && archey -c white
	[  "$UID" = "0" ] && archey -c green

fi

#PS1="\[\e[01;31m\]┌─[\[\e[01;35m\u\e[01;31m\]]──[\[\e[00;37m\]${HOSTNAME%%.*}\[\e[01;32m\]]:\w$\[\e[01;31m\]\n\[\e[01;31m\]└──\[\e[01;36m\]>>\[\e[0m\]"
alias ll="ls -lAFh"
# push script aliases
alias irc="TERM=xterm;ssh -t sabros /home/katana/scripts/weechat.sh"

alias push="/home/katana/push.sh"
alias pushscreen="/home/katana/push.sh -s"
alias pushfile="/home/katana/push.sh -u"
alias steam='WINEDEBUG=-all wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe >/dev/null 2>&1 &'
