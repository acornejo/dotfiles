#!/bin/bash

function createIndex()
{
    pushd "$1" >& /dev/null
    echo "<HTML>" > index.html
    echo "<HEAD><TITLE>File Index</TITLE></HEAD>" >> index.html
    echo '<BODY bgcolor="#FF9900" text="#FFFFFF" link="#FFFFFF" vlink="#FFFFFF" alink="#FFFFFF">' >> index.html
    if [ -n "$2" ]; then
                echo "<A HREF="$2">../</A><BR>" >> index.html
    fi
    for file in *; do
        if [ $file != "`basename $0`" -a $file != "index.html" ]; then
            if [ -d "$file" ]; then
                echo "<A HREF="$file">"$file"/</A><BR>" >> index.html
                createIndex $file $1
            else	
                echo "<A HREF="$file">"$file"</A><BR>" >> index.html	
            fi	
        fi
    done;
    echo "</BODY></HTML>" >> index.html
    chmod 666 index.html
    popd >& /dev/null
}

if [ -d "$1" ]; then
    createIndex $1
else
    createIndex .
fi
