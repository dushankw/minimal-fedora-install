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
    xcompmgr \
    xrandr \
    arandr \
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
    dzen2 \
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
    bind-utils \
    blivet-gui \
    git \
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
    colordiff

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

# Enable the upstream open h264 repo (exists as of Fedora 31)
umask 077
cat <<EOF > /etc/yum.repos.d/fedora-cisco-openh264.repo
name=Fedora $releasever openh264 (From Cisco) - $basearch
baseurl=https://codecs.fedoraproject.org/openh264/$releasever/$basearch/
type=rpm
enabled=1
enabled_metadata=1
metadata_expire=14d
repo_gpgcheck=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=True

[fedora-cisco-openh264-debuginfo]
name=Fedora $releasever openh264 (From Cisco) - $basearch - Debug
baseurl=https://codecs.fedoraproject.org/openh264/$releasever/$basearch/debug/
type=rpm
enabled=0
metadata_expire=28d
repo_gpgcheck=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
skip_if_unavailable=True
EOF

# Install h264 and a light weight media player
dnf -y install --refresh \
    gstreamer1-plugin-openh264 \
    parole

# Set graphical target and enable lightdm at boot
systemctl enable lightdm.service
systemctl set-default graphical.target

# Boot into the new environment
sync
reboot
