#!/bin/sh

PREFIX=/usr
TARGET=i586-mingw32msvc
PATH="$PREFIX/bin:$PREFIX/$TARGET/bin:$PATH"
export PATH
exec make prefix=$PREFIX/$TARGET CPP=$TARGET-g++ CXX=$TARGET-g++ CC=$TARGET-gcc LD=$TARGET-ld AR=$TARGET-ar AS=$TARGET-as $*
