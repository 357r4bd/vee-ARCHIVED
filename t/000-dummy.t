#!/bin/sh

VEE="../bin/vee"
VEELS="../bin/veels"
VEECAT="../bin/veecat"
REL_VERSION="0.9.9-zeta"
VERSION=`$VEE -v 2>&1`
VEEDIR="../tmp/vee-test-$$"

# check version

if [ "$VERSION" == "$REL_VERSION" ]; then
  echo ok 1 - version check
else 
  echo not ok 1 - version check
fi

# initialize

rm -rf "$VEEDIR" > /dev/null 2>&1 
mkdir -p "$VEEDIR"

TITLE="\"test post\""
MESSAGE="\"The world says, hello.\""
VEE_FIRST_RUN=`$VEE -d "$VEEDIR" -t "$TITLE" -m "$MESSAGE"`

RAW=`$VEELS -d "$VEEDIR"`
RAW="$VEEDIR/$RAW"

if [ -e "$RAW" ]; then
  echo ok 2 - initial post with -m
else
  echo not ok 2 - initial post  with -m
fi

TITLE_CHECK=`echo $RAW | $VEECAT -t`

if [ "$TITLE_CHECK" == "$TITLE" ]; then
  echo ok 3 - title check in initial post
else
  echo not ok 3 - title check in initial post
fi

echo 1..3
