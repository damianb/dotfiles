ZSH=$HOME/.oh-my-zsh
ZSH_THEME="crimson"
DISABLE_AUTO_UPDATE="true"
DISABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)
source $ZSH/oh-my-zsh.sh
setopt globdots
zstyle ':completion:*' special-dirs false
unsetopt AUTO_CD

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll="ls -lAFh"
function mkc() { mkdir "$1" && cd "$1"; }
alias listps='ps aux | grep -v "ps aux" | grep -Ev "\[.+\]" | grep -v grep'
alias memoryhog="ps aux | sort -nk +4 | tail -n 20"
function sizehog() { du -hd 1 "$@" | sort -h | tail -n 21 | head -n 20; }
alias du="du -h"
alias df="df -h"
alias netconnections="netstat -tuapwn"
alias ts="date +%s"

unalias gpu
alias gs="git status"
alias ga="git add"
alias gp="git push"
function gpu() { current=$(git rev-parse --abbrev-ref HEAD); git push -u origin $current $@ }
alias gg="git pull"

which thefuck >/dev/null
if [ $? -eq 0 ]; then
	eval "$(thefuck --alias)"
fi

export PATH="$PATH:$HOME/.bin:$HOME/.local/bin:/usr/local/bin"
export EDITOR=nano
