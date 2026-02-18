#!/bin/bash

# Wait for X session to be ready
sleep 5

# Detect screen width
WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d'x' -f1)
HEIGHT=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d'x' -f2)
echo "Detected width: $WIDTH"

# GTK / XFCE touch
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchscreen tap-to-click true

# Slightly smaller for padding
WIN_W=$(( WIDTH * 95 / 100 ))
WIN_H=$(( HEIGHT * 95 / 100 ))
# Touch/QT scaling
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCALE_FACTOR=1
export QT_SCREEN_SCALE_FACTORS=1
export QT_USE_NATIVE_WINDOWS=0
export QT_TOUCHSCREEN_CALIBRATION=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_ENABLE_HIGHDPI_SCALING=1
# Optional fix for stubborn dialogs
APP=$(xdotool search --onlyvisible --name "ComicTagger" | head -n1)
xdotool windowsize $APP $WIN_W $WIN_H
xdotool windowmove $APP 0 0

if [ "$WIDTH" -lt 800 ]; then
    # Mobile mode
    ICON=$(( $ICON * 2 ))
    PANEL=$(( $PANEL * 2 ))
    export QT_SCALE_FACTOR=1.5
    export GDK_SCALE=1
    export QT_TOUCHSCREEN_CALIBRATION=1
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_AUTO_SCREEN_SCALE_FACTOR=1       # auto-detect screen scaling
    export QT_SCREEN_SCALE_FACTORS=1.5
    export QT_FONT_DPI=144                      # increases font/button size
    APP=$(xdotool search --onlyvisible --name "ComicTagger")
    xdotool windowsize $APP $WIN_W $WIN_H
    xdotool windowmove $APP 0 0
elif [ "$WIDTH" -lt 1400 ]; then
    # Tablet mode
    ICON=$(( $ICON * 1.2 ))
    PANEL=$(( $PANEL * 1.2 ))
    export QT_SCALE_FACTOR=1.2
    export GDK_SCALE=1.2
    export QT_TOUCHSCREEN_CALIBRATION=1
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_SCREEN_SCALE_FACTORS=1.5
    export QT_FONT_DPI=144     
    APP=$(xdotool search --onlyvisible --name "ComicTagger")
    xdotool windowsize $APP $WIN_W $WIN_H
    xdotool windowmove $APP 0 0
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
