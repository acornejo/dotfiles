#!/bin/bash

EXPR=$1
shift

declare -A RENAMES
declare -A COLLISIONS
declare -A CONFLICTS

while [ -n "$1" ]; do
  OLDFILE=$1
  shift
  NEWFILE=$(echo $OLDFILE | sed "${EXPR}")
  if [ "$NEWFILE" != "$OLDFILE" ]; then
    if [ ${COLLISIONS[$NEWFILE]+exists} ]; then
      CONFLICTS[$OLDFILE]=$NEWFILE
      T=${COLLISIONS[$NEWFILE]}
      if [ ${RENAMES[$T]+exists} ]; then
        CONFLICTS[$T]=$NEWFILE
        unset RENAMES[$T]
      fi
    else
      RENAMES[$OLDFILE]=$NEWFILE
      COLLISIONS[$NEWFILE]=$OLDFILE
    fi
  fi
done

if [ ${#RENAMES[@]} -gt 0 ] || [ ${#CONFLICTS[@]} -gt 0 ]; then
  if [ ${#RENAMES[@]} -gt 0 ]; then
    echo "Renaming ${#RENAMES[@]} files:"
    for key in "${!RENAMES[@]}"; do
      echo "  $key -> ${RENAMES[$key]}"
    done
    echo
  fi

  if [ ${#CONFLICTS[@]} -gt 0 ]; then
    echo "Conflicts with ${#CONFLICTS[@]} files:"
    for key in "${!CONFLICTS[@]}"; do
      echo "  $key -> ${CONFLICTS[$key]}"
    done
    echo
  fi

  if [ ${#RENAMES[@]} -gt 0 ]; then
    echo "Proceed?"
    select yn in "Yes" "No"; do
      case $yn in
        Yes )
          for key in "${!RENAMES[@]}"; do
            mv "$key" "${RENAMES[$key]}"
          done
          exit 0
          ;;
        No )
          echo "Aborted."
          exit 1
          ;;
      esac
    done
  fi
fi
