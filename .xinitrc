#!/bin/bash

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=google-chrome

case $WM in
openbox)
	export DE=openbox
	dbus-launch openbox-session
	;;
xp)
	VirtualBox -startvm "Windows XP" -fullscreen
	;;
ubuntu)
	VirtualBox -startvm "ubuntu" -fullscreen
	;;
*)
	export DE=openbox
	dbus-launch openbox-session
	;;
esac
