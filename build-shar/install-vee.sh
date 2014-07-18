#!/bin/sh

IFS=

echo Checking local environment...

DEFAULT_PREFIX=$HOME/bin
DEFAULT_MANPATH=$HOME/man

echo "Install directory? [$DEFAULT_PREFIX]"
read PREFIX 

if [ -z "$PREFIX" ]; then
  PREFIX=$DEFAULT_PREFIX
fi

yN=
if [ ! -d "$PREFIX" ]; then
  echo "$PREFIX doesn't exist, create it? [yN] "
  read yN
   
  if [ "$yN" == "y" ]; then
    mkdir $PREFIX
  fi 
fi

echo "Manual directory? [$DEFAULT_MANPATH]"
read MANPATH 

if [ -z "$MANPATHPREFIX" ]; then
  MANPATH=$DEFAULT_MANPATH
fi

yN=
if [ ! -d "$MANPATHPREFIX" ]; then
  echo "$MANPATHPREFIX doesn't exist, create it? [yN] "
  read yN
   
  if [ "$yN" == "y" ]; then
    mkdir $MANPATHPREFIX
  fi 
fi

yN=
if [ -e "$PREFIX/vee" ]; then
  echo "$PREFIX/vee detected, proceed? [yN]"
  read yN
  if [ "$yN" != "y" ]; then
    echo "Exiting, nothing installed because vee may already be installed"
    exit 1
  fi
fi

cp -vf ./bin/vee* $PREFIX
chmod 0755 $PREFIX/vee*
cp -vf ./man/vee* $MANPATHPREFIX

echo
echo "Checking if vee is in your \$PATH (using 'which vee')"
if [ -z $(which vee) ]; then
  echo
  echo "... not found"
  echo
  echo "Please add the following lines to your $HOME/.profile"
  echo
  echo "export PATH=$PREFIX:\$PATH"
  echo "export MANPATH=$MANPATHPREFIX:\$MANPATHPREFIX"
else
  echo
  echo "... found"
  echo
  echo "Congratulations, vee is available to you in your \$PATH. Happy microblogging,"
fi
