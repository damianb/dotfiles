ZSH=$HOME/.oh-my-zsh
ZSH_THEME="crimson"
DISABLE_AUTO_UPDATE="true"
DISABLE_CORRECTION="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll="ls -lAFh"
function mkc() { mkdir $1; cd $1; }
alias listps='ps aux | grep -v "ps aux" | grep -Ev "\[.+\]" | grep -v grep'
alias memoryhog="ps aux | sort -nk +4 | tail -n 20"
function sizehog() { du -hd 1 $@ | sort -h | tail -n 21 | head -n 20; }
alias du="du -h"
alias df="df -h"
alias netconnections="netstat -tuapw --numeric-hosts --numeric-ports"
alias ts="date +%s"
alias sx="startx"

alias gs="git status"
alias ga="git add"
alias gp="git push"
alias gg="git pull"

unalias gc
function gcommit {
  m=$@
  m=$(printf " %s" "${m[@]}") # i should use sed for this...but meh, fuck it
  m=${m:1}
  git commit -m "$m"
}
alias gc="gcommit"

function gscommit {
  m=$@
  m=$(printf " %s" "${m[@]}") # i should use sed for this...but meh, fuck it
  m=${m:1}
  git commit -S -m "$m"
}
alias gsc="gscommit"

case `hostname` in
	# server
	(solanine.odios.us)
		alias irc="$HOME/scripts/weechat.sh"
	;;
	(*)
		alias irc="TERM=xterm;ssh -t solanine /home/katana/scripts/weechat.sh"
		function ss {
			UUID=$(uuidgen -r)
			scrot $HOME/.ss/$UUID.png && \
			scp -q $HOME/.ss/$UUID.png solanine:/home/katana/http/i/ && \
			echo "https://tilde.odios.us/i/$UUID.png" | xclip -selection clipboard
		}
	;;
esac

if [[ -f $HOME/.nvm/nvm.sh ]]; then
	source $HOME/.nvm/nvm.sh
fi

# update $PATH
export PATH="$PATH:$HOME/.bin:$HOME/node_modules/.bin"
