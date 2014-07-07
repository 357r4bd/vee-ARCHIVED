#!/bin/sh

# Test for Issue 4

IN=./001-sort.dat

 guess_arch()
{ case $(uname) in
  Linux)   ARCH='linux'
     ;;
  FreeBSD) ARCH='freebsd'
     ;;
  Darwin)  ARCH='macosx'
     ;;
  *)       ARCH='unknown'
     ;;
  esac
}

ARCH='unknown'
guess_arch

SORT="sort -t; +0f -1 +1nr"

case $ARCH in
 linux)   SORT="sort -t; +0f -1 +1nr"
    ;;
 freebsd) SORT="sort -t; +0f -1 +1nr"
    ;;
 macosx)  # -k2,2 sorts by second field as delimted by -t';' - this may actually work 
          # for all platforms 
          SORT="sort -t; -nr -k2,2"
    ;;
 *)       SORT="sort -t; +0f -1 +1nr"
    ;;
esac

c=0

cat $IN | $SORT > /tmp/$$.sorted

if [ "$ARCH" != 'macosx' ]; then

  c=$(($c+1))
  top=$(cat /tmp/$$.sorted | head -n 1 | awk '{print $6}') 
  if [ "$top" == "top" ]; then
    echo "ok $c - top line sorted where expected (old sort style)"
  fi

  c=$(($c+1))
  bot=$(cat /tmp/$$.sorted | tail -n 1 | awk '{print $6}') 
  if [ "$bot" == "bottom" ]; then
    echo "ok $c - bottom line sorted where expected (old sort style)"
  fi
  rm /tmp/$$.sorted
else
  echo ok $c - skipping old style sort on MacOSX
fi

# this section also tests new style sort options on all $ARCH

cat $IN | sort -t';' -nr -k2,2 > /tmp/$$.sorted

c=$(($c+1))
top=$(cat /tmp/$$.sorted | head -n 1 | awk '{print $6}') 
if [ "$top" == "top" ]; then
  echo "ok $c - top line sorted where expected (sort using -k2,2)"
fi
 
c=$(($c+1))
bot=$(cat /tmp/$$.sorted | tail -n 1 | awk '{print $6}') 
if [ "$bot" == "bottom" ]; then
  echo "ok $c - bottom line sorted where expected (sort using -k2,2)"
fi

rm /tmp/$$.sorted

echo 1..$c
