#! /bin/bash
# This Script is supposed to automatically upgragde Adobe Flash Player
# It just execute some command to build a slackware package, without
# modifying anything.
# 	Requires Internet connection for downloading.
#	Requires the lateset version as the ONLY INPUT parameter.
# Usage: 
#		./updateFlash $new_version
# <NightSky> #2016-09
# <nightskyfore@yahoo.co.jp>

# Execution Status Define
SUCCESS=0
NORMAL_ERROR=1
FAIL=2

ARCH=`arch`

# Root permission requried
if [ "$UID" -ne 0 ]
then
	echo "Must be root to run it. Try \'sudo\' please."
	exit $NORMAL_ERROR
fi

# Check for input
if [ -z $1 ]
then
	echo "Usage: ./`basename $0` \$new_version"
	exit $NORMAL_ERROR
fi

SOURCE_FILE=flash_player_npapi_linux.$ARCH.tar.gz
PKGNAME=flash
VERSION=$1
BUILD=ny_1
CWD=$(pwd)
TMP=/tmp/buildtest
PKG=$TMP/$PKGNAME-$VERSION

wget https://fpdownload.adobe.com/get/flashplayer/pdc/$VERSION/$SOURCE_FILE || \
	exit $FAIL

rm -rf $PKGNAME
rm -rf $PKG

mkdir -p $PKGNAME
mkdir -p $TMP $PKG

cd $PKGNAME
tar -xvf $CWD/$SOURCE_FILE || exit $FAIL
cp -r usr/ $PKG
mkdir $PKG/usr/lib/mozilla
mkdir $PKG/usr/lib/mozilla/plugins
cp libflashplayer.so $PKG/usr/lib/mozilla/plugins/

cd $PKG
mkdir install
cat > install/slack-desc << EOF
# HOW TO EDIT THIS FILE:
# The "handy ruler" below makes it easier to edit a package description.  Line
# up the first '|' above the ':' following the base package name, and the '|'
# on the right side marks the last column you can put a character in.  You must
# make exactly 11 lines for the formatting to be correct.  It's also
# customary to leave one space after the ':'.

     |-----handy-ruler----------------------------------------------------|
flash: flash (Adobe Flash Player)
flash:
flash: Adobe® Flash® Player is a lightweight browser plug-in and
flash: rich Internet application runtime that delivers consistent and
flash: engaging user experiences, stunning audio/video playback.
flash:
flash:
flash:
flash:
flash: Homepage: https://get.adobe.com/flashplayer/
flash:
EOF

/sbin/makepkg -l y -c n /tmp/$PKGNAME-$VERSION-$ARCH-$BUILD.tgz
upgradepkg --install-new /tmp/$PKGNAME-$VERSION-$ARCH-$BUILD.tgz

cd $CWD
rm -rf $CWD/$PKGNAME
rm -rf $PKG
rm -rf $CWD/$SOURCE_FILE
