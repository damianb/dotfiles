# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background and the font Inconsolata.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
# 
# http://ysmood.org/wp/2013/03/my-ys-terminal-theme/
# Mar 2013 ys

# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[white]%}[%{$reset_color%}git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[white]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}:%{$fg[red]%}[dirty]"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Prompt format: \n :: USER@MACHINE DIRECTORY git:BRANCH STATE \n $ 
PROMPT="
%{$fg_bold[grey]%}::%{$reset_color%} \
%{$fg_bold[yellow]%}[%{$reset_color%}%{$fg[white]%}%n@$(box_name)%{$fg_bold[yellow]%}]%{$reset_color%} \
%{$fg_bold[blue]%}${current_dir}%{$reset_color%}${git_info} 
%{$fg[green]%}$ %{$reset_color%}"
