# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}
local current_dir='${PWD/#$HOME/~}'
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[white]%}[%{$reset_color%}git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[white]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}:%{$fg[red]%}[dirty]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
if [[ $UID -eq 0 ]]; then
    CARETCOLOR="red"
    CARET="#"
else
    CARETCOLOR="green"
    CARET="$"
fi
PROMPT="%{$fg_bold[grey]%}::%{$reset_color%} \
%{$fg_bold[yellow]%}[%{$reset_color%}%{$fg[white]%}%n@$(box_name)%{$fg_bold[yellow]%}]%{$reset_color%} \
%{$fg_bold[blue]%}${current_dir}%{$reset_color%}${git_info} 
%{$fg[$CARETCOLOR]%}${CARET} %{$reset_color%}"
