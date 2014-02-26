#!/bin/bash

function query()
{
    prompt="$1: [y,n] "
    while [ "$RES" != "n" -a "$RES" != "y" ]; do
        read -p "$prompt" -s -n 1 RES
    done
    if [ "$RES" != "n" ]; then
        echo "yes"
        RES="yes"
    else
        echo "no"
        RES=""
    fi
}

query "Gnome-terminal Ctrl-[C/V] copy/paste shortucts"
if [ -n "$RES" ]; then
    gconftool-2 -t str -s /apps/gnome-terminal/keybindings/copy "<Control>c"
    gconftool-2 -t str -s /apps/gnome-terminal/keybindings/paste "<Control>v"
fi

query "Nautilus Single-Click"
if [ -n "$RES" ]; then
    gconftool-2 -t str -s /apps/nautilus/preferences/click_policy "single"
fi

query "Toolbars: Text beside icons"
if [ -n "$RES" ]; then
    gconftool-2 -t str -s /desktop/gnome/interface/toolbar_style "both-horiz"
fi

query "Keyboard Shortcuts: Volume + Songs"
if [ -n "$RES" ]; then
    gconftool-2 -t str -s /apps/gnome_settings_daemon/keybindings/volume_down "<Control><Alt>comma"
    gconftool-2 -t str -s /apps/gnome_settings_daemon/keybindings/volume_up   "<Control><Alt>period"
    gconftool-2 -t str -s /apps/gnome_settings_daemon/keybindings/next   "<Control><Alt>bracketright"
    gconftool-2 -t str -s /apps/gnome_settings_daemon/keybindings/previous   "<Control><Alt>bracketleft"
fi

MODKEY="<Mod4>"
query "Awesome keyboard shortucts"
if [ -n "$RES" ]; then
    gconftool-2 -t str -s /apps/metacity/window_keybindings/toggle_maximized "${MODKEY}m"
    gconftool-2 -t str -s /apps/metacity/window_keybindings/close "<Shift>${MODKEY}c"
    gconftool-2 -t int -s /apps/metacity/general/num_workspaces 6
    gconftool-2 -t str -s /apps/metacity/global_keybindings/switch_to_workspace_1 "${MODKEY}1"
    gconftool-2 -t str -s /apps/metacity/global_keybindings/switch_to_workspace_2 "${MODKEY}2"
    gconftool-2 -t str -s /apps/metacity/global_keybindings/switch_to_workspace_3 "${MODKEY}3"
    gconftool-2 -t str -s /apps/metacity/global_keybindings/switch_to_workspace_4 "${MODKEY}4"
    gconftool-2 -t str -s /apps/metacity/global_keybindings/switch_to_workspace_5 "${MODKEY}5"
    gconftool-2 -t str -s /apps/metacity/global_keybindings/switch_to_workspace_6 "${MODKEY}6"
    gconftool-2 -t str -s /apps/metacity/global_keybindings/switch_windows "${MODKEY}j"
    gconftool-2 -t str -s /apps/compiz/plugins/switcher/allscreens/options/next_all_key "${MODKEY}j"
    gconftool-2 -t str -s /apps/metacity/global_keybindings/switch_windows_backward "${MODKEY}k"
    gconftool-2 -t str -s /apps/compiz/plugins/switcher/allscreens/options/prev_all_key "${MODKEY}k"
    gconftool-2 -t str -s /apps/metacity/window_keybindings/move_to_workspace_1 "${MODKEY}<Shift>exclam"
    gconftool-2 -t str -s /apps/metacity/window_keybindings/move_to_workspace_2 "${MODKEY}<Shift>at"
    gconftool-2 -t str -s /apps/metacity/window_keybindings/move_to_workspace_3 "${MODKEY}<Shift>numbersign"
    gconftool-2 -t str -s /apps/metacity/window_keybindings/move_to_workspace_4 "${MODKEY}<Shift>dollar"
    gconftool-2 -t str -s /apps/metacity/window_keybindings/move_to_workspace_5 "${MODKEY}<Shift>percent"
    gconftool-2 -t str -s /apps/metacity/window_keybindings/move_to_workspace_6 "${MODKEY}<Shift>asciicircum"
fi

query "Keyboard Shortcuts: Vi, Terminal, Browser, etc."
if [ -n "$RES" ]; then
    commands=("gvim" "gnome-terminal" "chromium-browser" "xkill" "gmrun" "rhythmbox-client --play-pause")
    bindings=("<Control><Alt>E" "${MODKEY}Return" "<Control><Alt>G" "<Control><Alt>K" "${MODKEY}R" "<Control><Alt>P")
    num=${#commands[*]}
    for gpath in "/apps/metacity/keybinding_commands/command_" "/apps/compiz/plugins/commands/allscreens/options/command"; do
        for ((i=0; i<$num; i++)); do
            gconftool-2 -t str -s ${gpath}$i "${commands[$i]}"
        done
    done

    for gpath in "/apps/metacity/global_keybindings/run_command_" "/apps/compiz/plugins/commands/allscreens/options/run_command"; do
        if [ $gpath = "/apps/metacity/global_keybindings/run_command_" ]; then
            gfix=""
        else
            gfix="_key"
        fi
        for ((i=0; i<$num; i++)); do
            gconftool-2 -t str -s ${gpath}$i${gfix} "${bindings[$i]}"
        done
    done
fi
