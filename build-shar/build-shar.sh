#!/bin/sh

# this script will build the downloadable shar that will install vee locally

WORKDIR=./vee-builddir

rm -rf $WORKDIR  > /dev/null 2>&1

mkdir $WORKDIR
cd $WORKDIR
mkdir ./bin ./man 

# move utils
cp ../../bin/vee ./bin/vee
cp ../../bin/veecat ./bin/veecat
cp ../../bin/veefind ./bin/veefind
# set perms
chmod 700 ./bin/*

# generate documentation
cp -r ../../pod .
cd pod
make all > /dev/null 2>&1

mv -f *.[123456789] ../man
cd ..

cp ../install-vee.sh .

echo "PATH=\$PATH:\$HOME/bin" > .veeprofile
echo "MANPATH=\$MANPATH:\$HOME/man" >> .veeprofile

cd ..

# FreeBSD shar(1)
shar $(find $WORKDIR -print) > ./dont-use-install-vee.shar.tmp

echo "# kick off install process" >> ./dont-use-install-vee.shar.tmp
echo "cd $WORKDIR" >> ./dont-use-install-vee.shar.tmp
echo "sh ./install-vee.sh" >> ./dont-use-install-vee.shar.tmp

# filter out the exit at the end that shar(1) added
grep -v "^exit" ./dont-use-install-vee.shar.tmp > ./dont-use-install-vee.shar

rm -rf $WORKDIR > /dev/null 2>&1
