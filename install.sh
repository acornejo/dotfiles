#!/bin/bash

script_dir() {
    echo $(cd $(dirname $0) && git rev-parse --show-toplevel)
}

run_hook() {
    if [ -e "$1" ]; then
        (. $1)
    fi
}

link_file() {
    if [ ! -e "$1" ]; then
        return
    fi

    if [ -d "$1" ]; then
        if [ -e "$1/.linkdir" ]; then
            if [ -e "$2" ]; then
                rm -fr "$2"
            fi
            ln -sf "$1" "$2"
            return
        fi
        if [ ! -d "$2" ]; then
            mkdir -p $2
        fi
        local list=$4
        if [ -z "$list" ]; then
            list=$(ls -1 $1)
        fi
        run_hook "$1/.hook-pre"
        for f in $list; do
            if ! grep -Fxq "$f" "$1/.exclude" 2>/dev/null; then
                link_file "$1/$f" "$2/$3$f"
            fi
        done
        run_hook "$1/.hook-post"
    else
        if [ -e "$2" ]; then
            rm -f $2
        fi
        ln -sf $1 $2
    fi
}

undo() {
    echo "Deleting dotfiles.."
    FILES=$(find $HOME -maxdepth 4 -type l)
    for FILE in $FILES; do
        LINK=$(readlink $FILE)
    	if [[ ${LINK} = ${BASE_DIR}* ]]; then
            rm -f $FILE
        fi
    done
}

UNAME=$(uname)
HOSTNAME=$(hostname -s)
BASE_DIR=$(script_dir)

case $1 in
    -u|-uninstall|uninstall)
	undo
	;;
    *)
        link_file "$BASE_DIR" "$HOME" "." "$(ls -1 $BASE_DIR | grep -v '^host-\|^uname-')"
        link_file "$BASE_DIR/host-${HOSTNAME}" "$HOME" "."
        link_file "$BASE_DIR/uname-${UNAME}" "$HOME" "."
	;;
esac
