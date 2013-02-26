#!/bin/sh

VEE="../bin/vee"
VEELS="../bin/veels"
VEECAT="../bin/veecat"
REL_VERSION="0.9.9-zeta"
VERSION=`$VEE -v 2>&1`
VEEDIR="../tmp/vee-test-$$"

TEST_COUNT=1

# check version

if [ "$VERSION" == "$REL_VERSION" ]; then
	echo ok $TEST_COUNT - version check
else 
	echo not ok $TEST_COUNT - version check
fi

# initialize

rm -rf "$VEEDIR" > /dev/null 2>&1 

DIR_COUNT=1
mkdir -p "$VEEDIR/$DIR_COUNT"

TITLE="test post"
MESSAGE="The world says, hello."

VEE_FIRST_RUN=`$VEE -d "$VEEDIR/$DIR_COUNT" -t "$TITLE" -m "$MESSAGE"`
RAW=`$VEELS -d "$VEEDIR/$DIR_COUNT"`
RAW="$VEEDIR/$DIR_COUNT/$RAW"

TEST_COUNT=$(($TEST_COUNT+1))

if [ -e "$RAW" ]; then
	echo ok $TEST_COUNT - initial post with -m
else
	echo not ok $TEST_COUNT - initial post  with -m
fi

TEST_COUNT=$(($TEST_COUNT+1))

TITLE_CHECK=`echo $RAW | $VEECAT -t`
if [ "$TITLE_CHECK" == "$TITLE" ]; then
	echo ok $TEST_COUNT - title check in initial post
else
	echo not ok $TEST_COUNT - title check in initial post
fi

# loop and create series of posts
for i in 1 2 3 4 5; do
	TEST_COUNT=$(($TEST_COUNT+1))

	TITLE="test post $i"
	MESSAGE="The world says, hello. $i"
	VEE_NEXT_RUN=`$VEE -d "$VEEDIR/$DIR_COUNT" -t "$TITLE" -m "$MESSAGE"`
	POST_COUNT=`$VEELS -d "$VEEDIR/$DIR_COUNT" | wc -l` # should be 1 + $i
	RAW=`$VEELS -d "$VEEDIR/$DIR_COUNT" | head -n 1` # first is latest post

	TITLE_CHECK=`echo $VEEDIR/$DIR_COUNT/$RAW | $VEECAT -t`
	if [ "$TITLE_CHECK" == "$TITLE" ]; then
		echo ok $TEST_COUNT - title check in subsequent post: $TITLE_CHECK
	else
		echo not ok $TEST_COUNT - title check in subsequent post: $TITLE_CHECK
	fi
done

# init dir, now with batch mode
DIR_COUNT=$((DIR_COUNT+1))
mkdir -p "$VEEDIR/$DIR_COUNT"

VEE_BATCH_RUN=`echo $MESSAGE | $VEE -b -d "$VEEDIR/$DIR_COUNT" -t "$TITLE"`
RAW=`$VEELS -d "$VEEDIR/$DIR_COUNT"`
RAW="$VEEDIR/$DIR_COUNT/$RAW"

TEST_COUNT=$(($TEST_COUNT+1))

if [ -e "$RAW" ]; then
	echo ok $TEST_COUNT - initial post with -b
else
	echo not ok $TEST_COUNT - initial post  with -b
fi

TEST_COUNT=$(($TEST_COUNT+1))

TITLE_CHECK=`echo $RAW | $VEECAT -t`
if [ "$TITLE_CHECK" == "$TITLE" ]; then
	echo ok $TEST_COUNT - title check in initial post
else
	echo not ok $TEST_COUNT - title check in initial post
fi

# loop and create series of posts
for i in 1 2 3 4 5; do
	TEST_COUNT=$(($TEST_COUNT+1))

	TITLE="test post $i"
	MESSAGE="The world says, hello. $i"
	VEE_NEXT_RUN=`echo $MESSAGE | $VEE -b -d "$VEEDIR/$DIR_COUNT" -t "$TITLE"`
	POST_COUNT=`$VEELS -d "$VEEDIR/$DIR_COUNT" | wc -l` # should be 1 + $i
	RAW=`$VEELS -d "$VEEDIR/$DIR_COUNT" | head -n 1` # first is latest post

	TITLE_CHECK=`echo $VEEDIR/$DIR_COUNT/$RAW | $VEECAT -t`
	if [ "$TITLE_CHECK" == "$TITLE" ]; then
		echo ok $TEST_COUNT - title check in subsequent post: $TITLE_CHECK
	else
		echo not ok $TEST_COUNT - title check in subsequent post: $TITLE_CHECK
	fi
done

# clean up
rm -rf "$VEEDIR" > /dev/null 2>&1 

echo 1..$TEST_COUNT
