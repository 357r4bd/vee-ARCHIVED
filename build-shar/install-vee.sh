#!/bin/sh

IFS=

echo Checking local environment...

PREFIX=$(pwd)/bin
MANPATH=$(pwd)/man

if [ ! -d "$PREFIX" ]; then
  echo "$PREFIX doesn't exist, create it? [yN] "
  read yN
   
  if [ "$yN" == "y" ]; then
    mkdir $PREFIX
  fi 
fi

if [ ! -d "$MANPATH" ]; then
  echo "$MANPATH doesn't exist, create it? [yN] "
  read yN
   
  if [ "$yN" == "y" ]; then
    mkdir $MANPATH
  fi 
fi

