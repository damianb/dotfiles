#!/bin/bash
#
# Local push to own server
#
# Requires:
# - remote webserver (best used w/userdirs)
# - local package "xclip"
# - local package "scrot"
# - local package "notify-send"
# - local package "pngcrush"
# - internet connection...unless you do it all via LAN. why would you do it all over LAN?  are you some kind of introverted, lonely, angsty sadist?
#
# If you want it hooked up to a hotkey, figure out how to do that in $DISTRO yourself.
#
#### useful:
# alias push="/home/katana/scripts/push.sh"
# alias pushscreen="/home/katana/scripts/push.sh -s"
# alias pushfile="/home/katana/scripts/push.sh -u"
####

TEMP_DIR="/tmp/"
LOCAL_DIR="/home/katana/push/"
REMOTE_SCP="katana@sabros:/home/katana/public_html/push/"
WEB_URL_BASE="http://codebite.net/push/"

MODE="$1"
case "$MODE" in
 '-s' | '--screen' )
	FILENAME=`date +%s`"-${RANDOM}.png"
	echo live screenshot saving to "${LOCAL_DIR}${FILENAME}"
	scrot -d 0 "${TEMP_DIR}${FILENAME}"
	pngcrush -q "${TEMP_DIR}${FILENAME}" "${LOCAL_DIR}${FILENAME}"
	rm -f "${TEMP_DIR}${FILENAME}"
 ;;
 '-u' | '--upload' )
	FILENAME=${2##*/}
	EXT=${2##.*}
	echo copying file to "${TEMP_DIR}${FILENAME}" temporarily
	cp "$2" "${TEMP_DIR}${FILENAME}"
	case "$EXT" in
	 'png' )
		echo copying file to "${TEMP_DIR}/${FILENAME}" temporarily                                               │  rm ./-foo                                                                                                      
	        cp "$2" "${TEMP_DIR}${FILENAME}"
		rm -f "${TEMP_DIR}${FILENAME}"
		pngcrush -q "${TEMP_DIR}/${FILENAME}" "${LOCAL_DIR}${FILENAME}"
	 ;;
	 * )
		cp "$2" "${LOCAL_DIR}${FILENAME}"
	 ;;
	esac
 ;;
 * )
	echo 'invalid argument'
	exit
 ;;
esac

WEB_FILENAME=`md5sum "${LOCAL_DIR}${FILENAME}" | sed -e 's/\([^ ]*\) \(.*\(\..*\)\)$/\1\3/'`
scp "${LOCAL_DIR}${FILENAME}" "${REMOTE_SCP}${WEB_FILENAME}"
echo "file uploaded to ${REMOTE_SCP}${WEB_FILENAME}"
echo "upload viewable at ${WEB_URL_BASE}${WEB_FILENAME}"
echo "${WEB_URL_BASE}${WEB_FILENAME}" | xclip -selection clipboard
notify-send "Image uploaded, link copied to clipboard"
