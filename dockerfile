FROM lscr.io/linuxserver/webtop:ubuntu-xfce

RUN apt update && apt install -y \
    libxcb-cursor0 \
    libxcb-xinerama0 \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0

ENV QT_QPA_PLATFORMTHEME=qt6ct
ENV XDG_CURRENT_DESKTOP=XFCE
