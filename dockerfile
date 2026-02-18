FROM lscr.io/linuxserver/webtop:ubuntu-xfce

RUN apt update && apt install -y \
    libxcb-cursor0 \
    libxcb-xinerama0 \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0

COPY touch-mode.sh /usr/local/bin/touch-mode.sh
RUN chmod +x /usr/local/bin/touch-mode.sh
RUN echo "/usr/local/bin/touch-mode.sh &" >> /etc/xdg/autostart/touch-mode.desktop

RUN apt install -y onboard
RUN apt install -y libinput-tools xdotool
RUN apt install -y rar

ENV QT_QPA_PLATFORMTHEME=qt6ct
ENV XDG_CURRENT_DESKTOP=XFCE
