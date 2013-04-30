#!/bin/bash

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=google-chrome

case $DE in
openbox)
	export DE=openbox
	dbus-launch openbox-session
	;;
i3)
	export DE=i3
	compton &
	nitrogen --restore &
	start-pulseaudio-x11 &
	dunst -b &
	mpd &
	exec dbus-launch --exit-with-session --sh-syntax i3 -V -d all > ~/.i3/log/i3-$(date +'%F-%k-%M-%S') 2>&1
	;;
xp)
	VirtualBox -startvm "Windows XP" -fullscreen
	;;
*)
	export DE=i3
	compton &
	nitrogen --restore &
	start-pulseaudio-x11 &
	dunst -b &
	mpd &
	exec dbus-launch --exit-with-session --sh-syntax i3 > ~/.i3/log/i3-$(date +'%F-%k-%M-%S') 2>&1
	;;
esac
