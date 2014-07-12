#!/bin/sh

# this script will build the downloadable shar that will install vee locally

rm -rf ./bin ./man ./pod ./tmp .veeprofile > /dev/null 2>&1

mkdir ./bin ./man 

# move utils
cp ../bin/vee ./bin/vee
cp ../bin/veecat ./bin/veecat
cp ../bin/veefind ./bin/veefind
# set perms
chmod 700 ./bin/*

# generate documentation
cp -r ../pod .
cd pod
make all

mv -f *.[123456789] ../man
cd ..

echo "PATH=\$PATH:\$HOME/bin" > .veeprofile
echo "MANPATH=\$MANPATH:\$HOME/man" >> .veeprofile

shar ./bin ./man ./bin/* ./man/* .veeprofile > ./dont-use-install-vee.shar

rm -rf ./bin ./man ./pod .veeprofile > /dev/null 2>&1
