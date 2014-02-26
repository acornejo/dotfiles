#!/bin/sh

TARGET=i586-mingw32msvc

CONFIG_SHELL=/bin/sh
export CONFIG_SHELL
PREFIX=/usr/$TARGET
PATH="$PREFIX/bin:$PATH"
export PATH
cache=cross-config.cache
sh configure --cache-file="$cache" --prefix=$PREFIX \
	--with-msw --target=$TARGET --host=$TARGET --build=i586-linux \
	$*
status=$?
rm -f "$cache"
exit $status
