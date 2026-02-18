#!/bin/bash

# Wait for X session to be ready
sleep 5

# Detect screen width
WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d'x' -f1)

echo "Detected width: $WIDTH"

if [ "$WIDTH" -lt 800 ]; then
    echo "Mobile mode"
    DPI=192
    PANEL=64
    ICON=96
    onboard &
elif [ "$WIDTH" -lt 1400 ]; then
    echo "Tablet mode"
    DPI=144
    PANEL=48
    ICON=72
else
    echo "Desktop mode"
    DPI=96
    PANEL=32
    ICON=48
fi

# Apply scaling
xfconf-query -c xsettings -p /Xft/DPI -s $DPI
xfconf-query -c xfce4-panel -p /panels/panel-0/size -s $PANEL
xfconf-query -c xfce4-desktop -p /desktop-icons/icon-size -s $ICON

# Optional: Enable touchscreen mode
xfconf-query -c xsettings -p /Gtk/TouchscreenMode -s 1

echo "Touch scaling applied."
