#!/bin/bash

mute_toggle() {
    SINKS=$(pactl list sinks | awk -F# '/^Sink / {print $2}')
    if [[ -n $(pactl list sinks | grep 'Mute: yes') ]]; then
        for s in $SINKS; do
            pactl set-sink-mute $s 0
        done
    else
        for s in $SINKS; do
            pactl set-sink-mute $s 1
        done
    fi
}

volume_up() {
    SINKS=$(pactl list sinks | awk -F# '/^Sink / {print $2}')
    for s in $SINKS; do
        pactl set-sink-volume $s +5%
    done
}

volume_down() {
    SINKS=$(pactl list sinks | awk -F# '/^Sink / {print $2}')
    for s in $SINKS; do
        pactl set-sink-volume $s -- -5%
    done
}

case $1 in
    volup|up|raise)
        volume_up
        ;;
    voldown|down|lower)
        volume_down
        ;;
    mute)
        mute_toggle
        ;;
    pause|play)
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
        ;;
    next)
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
        ;;
    prev|previous)
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
        ;;
    stop)
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
        ;;
esac
