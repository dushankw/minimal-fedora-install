# Minimal Fedora i3 Desktop

Bootstrap a minimal i3 Linux desktop using Fedora on a modern laptop with Intel hardware (CPU/GPU/Wireless)

### Usage

0. Using the `netinstall` ISO do a `Minimal Install` of the OS (I suggest enabling `LUKS + LVM` and creating separate partitions for `/boot`, `/`, `/home`, `/var` and `swap`)
1. Run `bootstrap.sh` as root (machine will reboot at the end)

You should now have a functional desktop

At this point you may run any other provisioning scripts you have written

### Extras

There is an optional `extra-packages.sh` script that includes a number of additional tools I find useful
