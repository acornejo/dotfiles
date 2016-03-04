#!/bin/bash

case $1 in
  root)
    windowid="root"
    ;;
  active)
    windowid=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)" | cut -d' ' -f5)
    ;;
  "")
    windowid=$(xwininfo 2>/dev/null | awk '/Window id/ {print $4}')
    ;;
  *)
    windowid=$1
    ;;
esac

if [ -n "$windowid" ]; then
    file=$HOME/screenshot-$(date '+%Y%m%d-%H%M%S').png
    echo "capturing window $windowid to $file"
    import -window $windowid $file
else
    echo "unable to find window id."
fi
