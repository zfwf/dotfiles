_create_and_link_desktop_file() {
  echo "[Desktop Entry]\nName=$1\nExec=$2 %U\nIcon=$3\nType=Application\nStartupNotify=true" > $1.desktop
  ln -sf "$(readlink -f $1.desktop)" ~/.local/share/applications/$1.desktop
}

# vscode
zplugin ice wait lucid from"gh-r" as"program" bpick"*tar.gz" mv'codium -> code' sbin'code' pick'/dev/null'
zplugin light VSCodium/vscodium

# ff dev edition
zplugin ice as'program' pick'firefox/firefox' \
  atclone'tar jxf *.tar.bz2; _create_and_link_desktop_file firefox "$(readlink -f firefox/firefox)" firefox;' \
  atpull'%atclone'
zplugin snippet https://download-installer.cdn.mozilla.net/pub/devedition/releases/70.0b4/linux-x86_64/en-US/firefox-70.0b4.tar.bz2

# gitahead
zplugin ice wait lucid from"gh-r" as"program" bpick"*sh"  pick'./GitAhead/GitAhead' \
  atclone'./GitAhead*.sh --include-subdir;' \
  atpull'%atclone'
zplugin light gitahead/gitahead

