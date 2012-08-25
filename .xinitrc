#!/bin/bash

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=google-chrome
export DE=openbox

case $WM in
openbox)
	dbus-launch openbox-session
	;;
xp)
	VirtualBox -startvm "Windows XP" -fullscreen
	;;
ubuntu)
	VirtualBox -startvm "ubuntu" -fullscreen
	;;
*)
	dbus-launch openbox-session
	;;
esac
