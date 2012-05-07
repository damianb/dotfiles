#!/bin/bash
#
# Local push to own server
#
# Requires: 
# - remote webserver (best used w/userdirs)
# - local package "scrot"
# - local package "xclip"
# - local package "pngcrush"
#

TEMP_DIR="/tmp/"
LOCAL_DIR="/home/katana/push/"
REMOTE_SCP="katana@sabros:/home/katana/public_html/push/"
WEB_URL_BASE="http://codebite.net/~katana/push/"
FILENAME=`date +%s`"-${RANDOM}.png"

echo screenshot saving to "${LOCAL_DIR}${FILENAME}"
scrot -d 0 "${TEMP_DIR}${FILENAME}"

if [ $? -ne 0 ]
then
	notify-send -u critical "Screenshot failed"
else
	pngcrush -q "${TEMP_DIR}${FILENAME}" "${LOCAL_DIR}${FILENAME}"
	WEB_FILENAME=`md5sum "${LOCAL_DIR}${FILENAME}" | sed -e 's/\([^ ]*\) \(.*\(\..*\)\)$/\1\3/'`
	scp "${LOCAL_DIR}${FILENAME}" "${REMOTE_SCP}${WEB_FILENAME}"
	echo "file uploaded to ${REMOTE_SCP}${WEB_FILENAME}"
	echo "upload viewable at ${WEB_URL_BASE}${WEB_FILENAME}"
	echo "${WEB_URL_BASE}${WEB_FILENAME}" | xclip -selection clipboard
	notify-send "Image uploaded, link copied to clipboard"
fi
