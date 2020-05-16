# Minimal Fedora i3 Desktop

Bootstrap a minimal i3 Linux desktop using Fedora on a modern laptop with Intel hardware (CPU/GPU/Wireless).

This script is written to be used with the latest Fedora (at any given time) and is not maintained to be backwards compatible with older ones.

### Usage

Using the `netinstall` ISO do a `Minimal Install` of the OS (ensure you verify GPG signatures prior to use).

##### Suggested partition layouts

NOTE: My machine has a 256GB SSD and 8GB of RAM, I am making my partition/swap calculations based on this. Those with bigger/smaller disks may refer instead to the percentages.

Format your disk using the GPT paritioning scheme (UEFI systems can not boot from MBR formatted disks).

Create the following partitions:

| Partition | Allocation | Percentage | Format | Kind    |
| --------- | ---------- | ---------- | ------ | ------- |
| /boot     | 1GB        | 0.3        | ext4   | Primary |
| /boot/efi | 200MB      | 0.07       | fat32  | Primary |

Once you have created and formatted your two Primary partitions, create a third spanning the remainder of the disk and configure it as an encrypted LUKS container.

Atop that, create an LVM Physical Volume, followed by your remaining partitions (as Logical Volumes within it), format them as follows:

| Partition | Allocation | Percentage | Format | Kind    |
| --------- | ---------- | ---------- | ------ | ------- |
| /         | 20GB       | 7.8        | ext4   | LVM LV  |
| /home     | 100GB      | 39.06      | ext4   | LVM LV  |
| /var      | 120GB      | 46.87      | ext4   | LVM LV  |
| swap      | 8GB        | 3.12       | swap   | LVM LV  |

Finish your install and reboot.

Once booted, connect to the internet and run `bootstrap.sh` as root (machine will reboot at the end), you should now have a functional desktop.

At this point you may run any other provisioning scripts you have written.

### Extras

There is an optional `extra-packages.sh` script that includes a number of additional tools I find useful but do not belong in the base install.
