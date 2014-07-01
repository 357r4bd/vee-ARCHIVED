#!/bin/sh

vee="../bin/vee"
veels="../bin/veels"
veecat="../bin/veecat"
rel_version="1.00"
version=$($vee -v 2>&1)
veedir="../tmp/vee-test-$$"

test_count=1

# check version

if [ "$version" == "$rel_version" ]; then
	echo ok $test_count - version check
else 
	echo not ok $test_count - version check
fi

# initialize

rm -rf "$veedir" > /dev/null 2>&1 

dir_count=1
mkdir -p "$veedir/$dir_count"

title="test post"
message="the world says, hello."

vee_first_run=$($vee -d "$veedir/$dir_count" -t "$title" -m "$message")

raw=$($veels -d "$veedir/$dir_count")
raw="$veedir/$dir_count/$raw"

test_count=$(($test_count+1))

if [ -e "$raw" ]; then
	echo ok $test_count - initial post with -m
else
	echo not ok $test_count - initial post  with -m
fi

test_count=$(($test_count+1))

title_check=$(echo $raw | $veecat -t)
if [ "$title_check" == "$title" ]; then
	echo ok $test_count - title check in initial post
else
	echo not ok $test_count - title check in initial post
fi

# loop and create series of posts
for i in 1 2 3 4 5; do
	test_count=$(($test_count+1))

	title="test post $i"
	message="the world says, hello. $i"
	vee_next_run=$($vee -d "$veedir/$dir_count" -t "$title" -m "$message")
	post_count=$($veels -d "$veedir/$dir_count" | wc -l) # should be 1 + $i
	raw=$($veels -d "$veedir/$dir_count" | head -n 1) # first is latest post

	title_check=$(echo $veedir/$dir_count/$raw | $veecat -t)
	if [ "$title_check" == "$title" ]; then
		echo ok $test_count - title check in subsequent post: $title_check
	else
		echo not ok $TEST_COUNT - title check in subsequent post: $TITLE_CHECK
	fi
done

# init dir, now with batch mode
dir_count=$((dir_count+1))
mkdir -p "$veedir/$dir_count"

vee_batch_run=$(echo $message | $vee -b -d "$veedir/$dir_count" -t "$title")
raw=$($veels -d "$veedir/$dir_count")
raw="$veedir/$dir_count/$raw"

test_count=$(($test_count+1))

if [ -e "$raw" ]; then
	echo ok $test_count - initial post with -b
else
	echo not ok $test_count - initial post  with -b
fi

test_count=$(($test_count+1))

title_check=$(echo $raw | $veecat -t)
if [ "$title_check" == "$title" ]; then
	echo ok $test_count - title check in initial post
else
	echo not ok $test_count - title check in initial post
fi

# loop and create series of posts
for i in 1 2 3 4 5; do
	test_count=$(($test_count+1))

	title="test post $i"
	message="the world says, hello. $i"
	vee_next_run=$(echo $message | $vee -b -d "$veedir/$dir_count" -t "$title")
	post_count=$($veels -d "$veedir/$dir_count" | wc -l) # should be 1 + $i
	raw=$($veels -d "$veedir/$dir_count" | head -n 1) # first is latest post

	title_check=$(echo $veedir/$dir_count/$raw | $veecat -t)
	if [ "$title_check" == "$title" ]; then
		echo ok $test_count - title check in subsequent post: $title_check
	else
		echo not ok $test_count - title check in subsequent post: $title_check
	fi
done

# clean up
rm -rf "$veedir" > /dev/null 2>&1 

echo 1..$test_count
