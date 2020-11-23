# Minimal Fedora i3 Desktop

Bootstrap a minimal i3 Linux desktop using Fedora on a modern laptop with Intel hardware (CPU/GPU/Wireless).

This script is written to be used with the latest Fedora (at any given time) and is not maintained to be backwards compatible with older ones.

### Changes in Fedora 33

Fedora 33 introduced some large changes, namely deprecating swap on disk for ZRAM and moving the default filesystem to BTRFS, plus some security changes:

* We are following the Fedora team in adopting ZRAM over disk based swap (hence you will not see a swap partition created) and `bootstrap.sh` has been updated accordingly, the main reason for this is the promise of less disk thrashing
* We are **not** (yet) switching from ext4 to BTRFS since I am a heavy user of Virtualisation and there are some known issues (https://btrfs.wiki.kernel.org/index.php/Gotchas)
* Eventual rotation of Fedora Secure Boot Certificate (https://access.redhat.com/security/vulnerabilities/grub2bootloader), no action needed as yet for my hardware
* Introduction of NTS to replace cleartext NTP, discussed further on
* Moved to systemd-resolvd by default, we will use this

### Usage

Using the Fedora Server `netinstall` ISO (ensure you verify GPG signatures prior to use) do a `Minimal Install` of the OS.

##### Securing NTP

Chrony (the NTP client used in Fedora) supports NTS (a cryptographically secure replacement for NTP) as of Fedora 33 (https://fedoramagazine.org/secure-ntp-with-nts/).

I suggest setting `time.cloudflare.com` as your only NTP server and enabling it via the NTS protocol only.

##### Suggested partition layouts

NOTE: My machine has a 500GB SSD, I am making my partition calculations based on this.

**As stated, we are no longer using swap on disk, so you will not see a swap partition created.**

Format your disk using the GPT partitioning scheme (UEFI systems can not boot from MBR formatted disks).

Create the following partitions:

| Mount Point | Allocation | Format | Kind    |
| ----------- | ---------- | ------ | ------- |
| /boot       | 2GB        | ext4   | Primary |
| /boot/efi   | 200MB      | fat32  | Primary |

Once you have created and formatted your two primary partitions, create a third spanning the remainder of the disk and configure it as an encrypted LUKS container.

Atop that, create an LVM Physical Volume, followed by your remaining partitions (as Logical Volumes within it), format them as follows:

| Mount Point | Allocation | Format | Kind   |
| ----------- | ---------- | ------ | ------ |
| /home       | 200GB      | ext4   | LVM LV |
| /var        | 250GB      | ext4   | LVM LV |
| /           | 47.8GB     | ext4   | LVM LV |

Configure everything else to your liking, finish your install and reboot.

Once booted, connect to the internet (likely via Ethernet since the Minimal Install lacks wireless drivers) and run `bootstrap.sh` as root (machine will reboot at the end), you should now have a functional desktop.

At this point you may run any other provisioning scripts you have written.

##### Additional Chrony configuration

* Add `ntsdumpdir /var/lib/chrony` to `/etc/chrony.conf` to enable some caching for NTS
* Remove `sourcedir /run/chrony-dhcp` from `/etc/chrony.conf` to ensure DHCP does not override your NTP settings
* Make sure to `systemctl restart chronyd`

### Extras

There is an optional `extra-packages.sh` script that includes a number of additional tools I find useful but do not belong in the base install.
