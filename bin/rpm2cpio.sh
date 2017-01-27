#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: $(basename $0) file.rpm"
  echo
  echo "       example: $(basename $0) test.rpm > file.cpio"
  echo "                $(basename $0) test.rpm | cpio -iduv"
fi
RPMHDRLGTH=$(LANG=X grep -abom1 '.7zXZ\|]'$'\000\000''....'$'\377\377\377\377\377\377''\|BZh9\|'$'\037\213\b' "$1")
case "$RPMHDRLGTH" in
  *7zXZ) COMPRESSOR=xz ;;
  *]*)   COMPRESSOR=lzma ;;
  *BZh9) COMPRESSOR=bzip2 ;;
  *)     COMPRESSOR=gzip ;;
esac
tail -c+$[${RPMHDRLGTH%:*}+1] "$1" | $COMPRESSOR -d
