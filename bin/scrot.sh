#!/bin/bash
windowid=$(xwininfo 2>/dev/null | awk '/Window id/ {print $4}')

if [ -n "$windowid" ]; then
    file=$HOME/screenshot-$(date '+%Y%m%d-%H%M%S').png
    echo "capturing window $windowid to $file"
    import -window $windowid $file
else
    echo "unable to find window id."
fi
