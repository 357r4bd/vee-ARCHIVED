#!/bin/sh

# this filter is a null filter; meaning it spits out
# exactly what was passed in

FORMAT_FUNC=$1 # the name of the format function used is passed in

IFS=""                     # ensures that leading spaces are retained
while read -r IN <&0 ; do  # break after 1 sec of no stdin
 echo "${IN}"              # echo's stdin back out so user can see 
done
