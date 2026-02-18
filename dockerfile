FROM lscr.io/linuxserver/webtop:ubuntu-xfce

RUN apt update && \
    apt install -y qt6ct onboard libinput-tools

ENV QT_QPA_PLATFORMTHEME=qt6ct
ENV XDG_CURRENT_DESKTOP=XFCE
