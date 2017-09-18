#!/bin/bash
set -euo pipefail

# Only root can run this script
[ $UID -eq 0 ] || exit 1

# X server and drivers
dnf -y install \
    glx-utils \
    mesa-dri-drivers \
    plymouth-system-theme \
    xorg-x11-drv-evdev \
    xorg-x11-drv-fbdev \
    xorg-x11-drv-intel \
    xorg-x11-drv-libinput \
    xorg-x11-drv-vesa \
    xorg-x11-server-Xorg \
    xorg-x11-utils \
    xorg-x11-xauth \
    xorg-x11-xinit

# Desktop
dnf -y install \
    adwaita-gtk2-theme \
    adwaita-icon-theme \
    i3 \
    lightdm \
    lightdm-gtk \
    pulseaudio \
    pulseaudio-utils \
    gnome-terminal \
    bash-completion \
    NetworkManager-wifi \
    iwl7260-firmware \
    firefox \
    git \
    vim

# Fonts
dnf -y install \
    dejavu-sans-fonts \
    dejavu-sans-mono-fonts \
    dejavu-serif-fonts \
    liberation-mono-fonts \
    liberation-sans-fonts \
    liberation-serif-fonts

# Codecs
dnf -y install \
    gstreamer1 \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugins-bad-free-gtk \
    gstreamer1-plugins-base \
    gstreamer1-plugins-good

# Set graphical target
systemctl enable lightdm.service
systemctl set-default graphical.target
sync
reboot
