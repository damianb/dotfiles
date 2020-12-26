#
#   crimson oh-my-zsh theme
#   copyright (c) 2013 Damian Bushong
#
#   license: MIT license (full text as follows)
#
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included in
#   all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#   THE SOFTWARE.
#


# these are simply provided to make the prompt more readable...or at least make an attempt at it
local RED="%{$fg[red]%}"
local BRED="%{$fg_bold[red]%}"
local GREEN="%{$fg[green]%}"
local BGREEN="%{$fg_bold[green]%}"
local BBLUE="%{$fg_bold[blue]%}"
local BYELLOW="%{$fg_bold[yellow]%}"
local BGREY="%{$fg_bold[grey]%}"
local CYAN="%{$fg[cyan]%}"
local BWHITE="%{$fg_bold[white]%}"
local WHITE="%{$fg[white]%}"
local RESET="%{$reset_color%}"

local CURRENT_DIR='${PWD/#$HOME/~}'
local GIT_STAT='$(git_prompt_info)'
local HOST=$(cat /etc/hostname | cut -d "." -f1)
local CARET_COLOR=$GREEN
local CARET="$"
local CONNECTION=""

# various git-oriented things for indicating if we're in a repo, what branch it is, if it's dirty, etc...
# this is intended to provide simple data, nothing more, to keep focus on output
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$BWHITE%}[%{$RESET%}git:%{$CYAN%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$BWHITE%}]%{$RESET%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$WHITE%}:%{$RESET%}%{$RED%}[dirty]%{$RESET%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# change prompt caret and color if we're root (uid 1)
if [[ $UID -eq 0 ]]; then
    CARET_COLOR=$RED
    CARET="#"
fi

# if it's an ssh connection, display an arrow to indicate this
if [[ -n $SSH_CONNECTION ]]; then
    CONNECTION="%{$GREEN%}->%{$RESET%} "
fi

#
# the rest of this is an ugly clusterfsck. this results in a two-line prompt, with the second line being a simple caret for input.
# all relevant information should be on the first line to keep things brief.
#
# the prompt starts with a double ::, which will turn red if the last command returned a nonzero status (error)
# this is followed by an arrow (if the session is over ssh), then the user@host string. afterwards, the current directory is displayed (relative to $HOME if we're in it)
# then newline, and caret
#

PROMPT="%(?.%{$BGREY%}.%{$RED%})::%{$RESET%} \
%{${CONNECTION}%}\
%{$BYELLOW%}[%{$RESET%}%{$WHITE%}%n@%{$HOST%}%{$BYELLOW%}]%{$RESET%} \
%{$BBLUE%}${CURRENT_DIR}%{$RESET%}\
%{$GIT_STAT%} 
%{$CARET_COLOR%}$CARET %{$RESET%}"
