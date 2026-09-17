#!/usr/bin/env bash
set -euo pipefail
cd /tmp
curl -fsSL -o silent.tar.gz https://github.com/uiriansan/SilentSDDM/archive/refs/tags/v1.5.0.tar.gz
tar -xzf silent.tar.gz
mkdir -p /usr/share/sddm/themes/silent
cp -rf SilentSDDM-1.5.0/. /usr/share/sddm/themes/silent/
mkdir -p /usr/share/fonts/silentsddm
cp -r /usr/share/sddm/themes/silent/fonts/. /usr/share/fonts/silentsddm/

# KyteOS preset based on rei.conf
cp /usr/share/sddm/themes/silent/configs/rei.conf /usr/share/sddm/themes/silent/configs/kyteos.conf

# Pick first wallpaper from /usr/share/ublue-os/kyteos/wallpapers (if any)
WALL="$(find /usr/share/ublue-os/kyteos/wallpapers -maxdepth 1 -type f ! -name '.*' -print -quit 2>/dev/null || true)"
if [ -n "$WALL" ]; then
  ext="${WALL##*.}"
  dest="/usr/share/sddm/themes/silent/backgrounds/kyteos-default.$ext"
  cp "$WALL" "$dest"
  if grep -q '^Background=' /usr/share/sddm/themes/silent/configs/kyteos.conf; then
    sed -i "s|^Background=.*|Background=backgrounds/kyteos-default.$ext|" /usr/share/sddm/themes/silent/configs/kyteos.conf
  fi
fi

sed -i 's|^ConfigFile=.*|ConfigFile=configs/kyteos.conf|' /usr/share/sddm/themes/silent/metadata.desktop
rm -rf /tmp/silent.tar.gz /tmp/SilentSDDM-1.5.0
