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
#
# Copyright (c) 2012 Damian Bushong
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
#

TEMP_DIR="/tmp/"
LOCAL_DIR="/home/katana/push/"
REMOTE_SCP="katana@sabros:/home/katana/public_html/push/"
WEB_URL_BASE="http://odios.us/push/"
WEB_SHORTENER="http://odios.us/url/?file="

if [ "$2"  == '--thumb' ]
then
	THUMBFILENAME=""
	GEN_THUMBNAIL="-t 50% "
else
	THUMBFILENAME=""
	GEN_THUMBNAIL=""
fi

case "$1" in
 '-s' | '--screen' )
	FILENAME="$(mktemp --tmpdir=${LOCAL_DIR} push-`date +%s`-XXXXXXXX.png)"
	FILENAME=${FILENAME##*/}
	if [ -n "$GEN_THUMBNAIL" ]
        then
		THUMBFILENAME="${FILENAME/.png/-thumb.png}"
        fi
	chmod 0664 "${LOCAL_DIR}${FILENAME}"
	echo live screenshot saving to "${LOCAL_DIR}${FILENAME}"
	scrot -z $GEN_THUMBNAIL -d 0 "${TEMP_DIR}${FILENAME}"
	echo pngcrushing "${FILENAME}"
	pngcrush -q "${TEMP_DIR}${FILENAME}" "${LOCAL_DIR}${FILENAME}"
	if [ -n "$GEN_THUMBNAIL" ]
	then
		echo pngcrushing "${THUMBFILENAME}"
		pngcrush -q "${TEMP_DIR}${THUMBFILENAME}" "${LOCAL_DIR}${THUMBFILENAME}"
		rm -f "${TEMP_DIR}${THUMBFILENAME}"
	fi
	rm -f "${TEMP_DIR}${FILENAME}"
 ;;
 '-js' | '--jpegscreen' )
	FILENAME="$(mktemp --tmpdir=${LOCAL_DIR} push-`date +%s`-XXXXXXXX.jpg)"
	FILENAME=${FILENAME##*/}
	if [ -n "$GEN_THUMBNAIL" ]
	then
		THUMBFILENAME="${FILENAME/.png/-thumb.png}"
	fi
	chmod 0664 "${LOCAL_DIR}${FILENAME}"
	echo live screenshot saving to "${LOCAL_DIR}${FILENAME}"
        scrot -z $GEN_THUMBNAIL -d 0 "${LOCAL_DIR}${FILENAME}"
 ;;
 '-u' | '--upload' )
	FILENAME=${2##*/}
	case "${2##.*}" in
	 'png' )
		echo copying file to "${TEMP_DIR}/${FILENAME}" temporarily
	        cp "$2" "${TEMP_DIR}${FILENAME}"
		echo pngcrushing "${FILENAME}"
		pngcrush -q "${TEMP_DIR}/${FILENAME}" "${LOCAL_DIR}${FILENAME}"
		rm -f "${TEMP_DIR}${FILENAME}"
	 ;;
	 * )
		cp "$2" "${LOCAL_DIR}${FILENAME}"
	 ;;
	esac
 ;;
 '-h' | '--help' )
	echo 'Usage:'
	echo '  push [OPTION...]'
	echo ''
	echo '  -s,  --screen			Take, archive, and upload a PNG screenshot'
	echo '  -js, --jpegscreen		Take, archive, and upload a JPEG screenshot'
	echo '       --thumb			Take and upload a thumbnail of the screenshot (jpg and png)'
	echo '				Warning: thumbnail URL will not be inserted into clipboard'
	echo '  -u,  --upload FILE		Archive and upload specified FILE'
	echo '       --help			display this help and exit'
#	echo '       --version			output version information and exit'
	echo ''
	echo 'Magic push script (c) 2012 codebite.net'
	echo 'Licensed under the MIT License <http://www.opensource.org/licenses/mit-license.php>'
	echo 'Source available at <https://github.com/damianb/dotfiles/blob/master/scripts/push.sh>'
	exit;
 ;;
 * )
	echo 'invalid argument'
	exit
 ;;
esac

WEB_FILENAME=`md5sum "${LOCAL_DIR}${FILENAME}" | sed -e 's/\([^ ]*\) \(.*\(\..*\)\)$/\1\3/'`
scp "${LOCAL_DIR}${FILENAME}" "${REMOTE_SCP}${WEB_FILENAME}"
echo "file uploaded to ${REMOTE_SCP}${WEB_FILENAME}"

THUMBURL=""
if [ -n "$GEN_THUMBNAIL" ]
then
	WEB_THUMBFILENAME=`md5sum "${LOCAL_DIR}${THUMBFILENAME}" | sed -e 's/\([^ ]*\) \(.*\(\..*\)\)$/\1\3/'`
	scp "${LOCAL_DIR}${THUMBFILENAME}" "${REMOTE_SCP}${WEB_THUMBFILENAME}"
	echo "thumbnail uploaded to ${REMOTE_SCP}${WEB_THUMBFILENAME}"
fi

URL=${WEB_URL_BASE}${WEB_FILENAME}
if [ -n "$WEB_SHORTENER" ]
then
	if [ -n "$GEN_THUMBNAIL" ]
	then
		SHORTENER=`curl -L -s "${WEB_SHORTENER}${WEB_THUMBFILENAME}"`
	        if [ "${SHORTENER:0:5}" == 'clear' ]
	        then
	                THUMBURL="&thumb=${SHORTENER:7}"
	        fi
	fi

	SHORTENER=`curl -L -s "${WEB_SHORTENER}${WEB_FILENAME}${THUMBURL}"`
	if [ "${SHORTENER:0:5}" == 'clear' ]
	then
		URL=${SHORTENER:7}
	fi
fi

if [ -n "$GEN_THUMBNAIL" ]
then
	rm -f "${LOCAL_DIR}${THUMBFILENAME}"
fi

echo $URL | xclip -selection clipboard
echo upload viewable at $URL
notify-send "Image uploaded, link copied to clipboard"
