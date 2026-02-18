#!/bin/bash

# Wait for X session to be ready
sleep 5

# Detect screen width
WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d'x' -f1)

echo "Detected width: $WIDTH"

if [ "$WIDTH" -lt 800 ]; then
    # Mobile mode
    ICON=$(( $ICON * 2 ))
    PANEL=$(( $PANEL * 2 ))
    export QT_SCALE_FACTOR=1
    export GDK_SCALE=1
    export QT_TOUCHSCREEN_CALIBRATION=1
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
elif [ "$WIDTH" -lt 1400 ]; then
    # Tablet mode
    ICON=$(( $ICON * 1.2 ))
    PANEL=$(( $PANEL * 1.2 ))
    export QT_SCALE_FACTOR=1.2
    export GDK_SCALE=1.2
    export QT_TOUCHSCREEN_CALIBRATION=1
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
else
    # Desktop mode
    ICON=$ICON
    PANEL=$PANEL
    export QT_SCALE_FACTOR=1
    export GDK_SCALE=1
fi

# Apply scaling
xfconf-query -c xsettings -p /Xft/DPI -s $DPI
xfconf-query -c xfce4-panel -p /panels/panel-0/size -s $PANEL
xfconf-query -c xfce4-desktop -p /desktop-icons/icon-size -s $ICON

# Optional: Enable touchscreen mode
xfconf-query -c xsettings -p /Gtk/TouchscreenMode -s 1

xfdesktop --reload

echo "Touch scaling applied."
