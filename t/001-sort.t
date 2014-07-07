#/bin/sh

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

linux="sort -t';' +0f -1 +1nr"
freebsd="sort -t';' +0f -1 +1nr"
macosx="sort -t';' -nr -k2,2"

cat $IN | sort -t';' +0f -1 +1nr

cat $IN | sort -t';' -nr -k2,2
