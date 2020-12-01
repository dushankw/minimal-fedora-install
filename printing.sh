#!/bin/bash
set -euo pipefail

# Everything you need to use HP printers under Linux

[ $UID -eq 0 ] || exit 1

dnf -y install \
    cups \
    hplip
