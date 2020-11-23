#!/bin/bash
set -euo pipefail

# Only root can run this script
[ $UID -eq 0 ] || exit 1

# Ensure the system is up to date
dnf update -y --refresh

# X server and drivers
dnf -y install \
    glx-utils \
    mesa-dri-drivers \
    mesa-vulkan-drivers \
    plymouth-system-theme \
    xorg-x11-drv-evdev \
    xorg-x11-drv-fbdev \
    xorg-x11-drv-intel \
    xorg-x11-drv-libinput \
    xorg-x11-drv-vesa \
    xorg-x11-server-Xorg \
    xorg-x11-server-utils \
    xorg-x11-utils \
    xorg-x11-xauth \
    xorg-x11-xinit \
    xbacklight \
    redshift \
    picom \
    xsel \
    xclip \
    xkill

# Wireless drivers (the 7260 package contains firmwares for many other Intel cards too)
dnf -y install \
    iwl7260-firmware \
    linux-firmware

# Desktop
dnf -y install \
    adwaita-gtk2-theme \
    adwaita-icon-theme \
    i3 \
    i3lock \
    dmenu \
    xautolock \
    x11-ssh-askpass \
    openssh-askpass \
    lightdm \
    lightdm-gtk \
    libappindicator \
    notification-daemon \
    xfce4-screenshooter \
    firefox \
    feh \
    thunar

# System tools
dnf -y install \
    udiskie \
    upower \
    xdg-utils \
    lm_sensors \
    xsensors \
    dbus-x11 \
    gnome-terminal \
    gnome-logs \
    bash-completion \
    gnome-disk-utility \
    NetworkManager-tui \
    NetworkManager-wifi \
    network-manager-applet \
    net-tools \
    wireless-tools \
    bind-utils \
    blivet-gui \
    git \
    git-gui \
    tmux \
    vim \
    whois \
    traceroute \
    unzip \
    eog \
    tree \
    htop \
    fzf \
    rsync \
    colordiff \
    mtr \
    psmisc \
    words \
    ranger \
    smem \
    firejail \
    keepassx \
    dnf-utils \
    pesign

# Fonts
dnf -y install \
    fontconfig \
    dejavu-sans-fonts \
    dejavu-sans-mono-fonts \
    dejavu-serif-fonts \
    liberation-mono-fonts \
    liberation-sans-fonts \
    liberation-serif-fonts

# Optional Fonts for Asian languages (you'll encounter ugliness in browsers without these)
dnf -y install \
    adobe-source-han-sans-cn-fonts \
    adobe-source-han-serif-cn-fonts \
    google-noto-sans-thai-fonts \
    google-noto-serif-thai-fonts \
    un-core-batang-fonts

# Codecs
dnf -y install \
    gstreamer1 \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugins-bad-free-gtk \
    gstreamer1-plugins-base \
    gstreamer1-plugins-good

# Sound
dnf -y install \
    pulseaudio \
    pulseaudio-libs \
    pulseaudio-utils \
    alsa-plugins-pulseaudio \
    alsa-utils \
    pavucontrol \
    volumeicon

# Install h264 and a light weight media player
dnf -y install \
    gstreamer1-plugin-openh264 \
    parole

# ZRAM for Swap
dnf -y install \
    zram-generator \
    zram-generator-defaults

# Set graphical target and enable lightdm at boot
systemctl enable lightdm.service
systemctl set-default graphical.target

# Disable sshd since the system is not yet hardened
# shellcheck disable=SC2216
systemctl disable sshd | true

# Boot into the new environment
echo 'Rebooting in 10 seconds...'
sleep 10
sync
reboot
