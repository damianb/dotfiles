#!/bin/sh

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=firefox
export EDITOR=nano
export DE=i3
export QT_STYLE_OVERRIDE=gtk

compton &
nitrogen --restore &
syndaemon -t -k -i 2 &
#start-pulseaudio-x11 &
#dunst -b &
#mpd &
exec dbus-launch --exit-with-session --sh-syntax i3 -V -d all > /home/katana/.i3/i3.log 2>&1
