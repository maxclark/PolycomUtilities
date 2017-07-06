#!/usr/bin/env bash
#
# extract_firmware.sh is a script to unpack and rename Polycom firmware files
#
# Copyright (c) 2017 Max Clark
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

USAGE="Usage: $0 firmware.zip version"

if [ "$#" -ne "2" ]; then
	echo "$USAGE"
	exit 1
fi

FILE=$1
VERSION=$2

# the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# the temp directory used, within $DIR
WORK_DIR=$DIR/unpack-$RANDOM
mkdir "$WORK_DIR"

# check for $WORK_DIR
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create $WORK_DIR"
  exit 1
fi

# the version directory used, within $DIR
VERSION_DIR=$DIR/version-$VERSION
mkdir "$VERSION_DIR"

# check for $VERSION
if [[ ! "$VERSION_DIR" || ! -d "$VERSION_DIR" ]]; then
  echo "Could not create $VERSION_DIR"
  exit 1
fi

# deletes the temp directory
function cleanup {
  rm -rf "$WORK_DIR"
  echo "Deleted temp working directory $WORK_DIR"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

/usr/bin/unzip $FILE -d "$WORK_DIR"

mv "$WORK_DIR/2345-17960-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx1500.uc.ld"
# 3111-17823-001.dect.ld vvxd60
# 3111-33215-001.sip.ld
mv "$WORK_DIR/3111-40250-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx101.uc.ld"
mv "$WORK_DIR/3111-40450-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx201.uc.ld"
mv "$WORK_DIR/3111-44500-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx500.uc.ld"
mv "$WORK_DIR/3111-44600-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx600.uc.ld"
mv "$WORK_DIR/3111-46135-002.sip.ld" "$VERSION_DIR/sip$VERSION-vvx300.uc.ld"
mv "$WORK_DIR/3111-46157-002.sip.ld" "$VERSION_DIR/sip$VERSION-vvx400.uc.ld"
mv "$WORK_DIR/3111-46161-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx310.uc.ld"
mv "$WORK_DIR/3111-46162-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx410.uc.ld"
mv "$WORK_DIR/3111-48300-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx301.uc.ld"
mv "$WORK_DIR/3111-48350-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx311.uc.ld"
mv "$WORK_DIR/3111-48400-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx401.uc.ld"
mv "$WORK_DIR/3111-48450-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx411.uc.ld"
mv "$WORK_DIR/3111-48500-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx501.uc.ld"
mv "$WORK_DIR/3111-48600-001.sip.ld" "$VERSION_DIR/sip$VERSION-vvx601.uc.ld"
