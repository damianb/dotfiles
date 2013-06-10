HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=3000
setopt appendhistory autocd extendedglob prompt_subst extended_history histignorespace completeinword nohup auto_pushd nobeep noglobdots

if [ -d "$HOME/node_modules/.bin/" ]; then
	export PATH=$PATH:$HOME/node_modules/.bin/
fi

zstyle :compinstall filename '/home/katana/.zshrc'
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll="ls -lAFh"
function mkdircd() { mkdir $1; cd $1; }
alias mkc=mkdircd
alias irc="TERM=xterm;ssh -t solanine /home/katana/scripts/weechat.sh"
alias listps='ps aux | grep -v "ps aux" | grep -Ev "\[.+\]" | grep -v grep'
alias memoryhog="ps aux | sort -nk +4 | tail -n 20"
function sizehog() { du -hd 1 $@ | sort -h | tail -n 21 | head -n 20; }
alias du="du -h"
alias df="df -h"
alias netconnections="netstat -tuapw --numeric-hosts --numeric-ports"
alias ts="date +%s"

alias gs="git status"
alias ga="git add"
alias gp="git push"
alias gg="git pull"

function gc {
    m=$@
	m=$(printf " %s" "${m[@]}") # i should use sed for this...but meh, fuck it
	m=${m:1}
	git commit -m "$m"
}

# easy extract, nabbed from reddit.
function extract {
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

autoload -Uz compinit colors promptinit zkbd && colors && promptinit && compinit
PROMPT="%{$fg[green]$bold_color%}:%{$reset_color$fg[white]$bold_color%}%n%{$fg[white]$bold_color%}@%m %{$fg[blue]$bold_color%}%~/ $prompt_newline%{$fg[yellow]$reset_color$fg[green]%}$%{$reset_color%} "

# binds
[[ ! -f ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]] && zkbd
source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
#source ${ZDOTDIR:-$HOME}/.zkbd/xterm-:0

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

case "$TERM" in
xterm*|rxvt*)
	preexec () {
		if [[ $1 != ^%m ]] then;
			print -Pn "\e]0;/bin/zsh\a"
		else
			print -Pn "\e]0;$1\a"
		fi
	}
	precmd() {
		print -Pn "\e]0;/bin/zsh\a"
	}
	#precmd() { print -Pn "\e]0;%m:%~\a" }
	#preexec () { print -Pn "\e]0;$1\a" }
	;;
*)
	;;
esac
