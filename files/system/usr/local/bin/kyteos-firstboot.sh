#!/usr/bin/env bash
MARKER="$HOME/.config/.kyteos-firstboot-done"
[ -f "$MARKER" ] && exit 0
WALL="$(find /usr/share/ublue-os/kyteos/wallpapers -type f ! -name '.gitkeep' | sort | head -n1)"
[ -n "$WALL" ] && plasma-apply-wallpaperimage "$WALL"
touch "$MARKER"
