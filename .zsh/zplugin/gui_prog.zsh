_create_and_link_desktop_file() {
  echo "[Desktop Entry]\nName=$1\nExec=$2 %U\nIcon=$3\nType=Application\nStartupNotify=true" > $1.desktop
  ln -sf "$(readlink -f $1.desktop)" ~/.local/share/applications/$1.desktop
}

# vscode
zplugin ice wait lucid from"gh-r" as"program" bpick"*tar.gz" mv'codium -> code' sbin'code' pick'/dev/null'
zplugin light VSCodium/vscodium

# ff dev edition
zplugin ice id-as"ff-dev" as'program' pick'firefox/firefox' \
  mv'ff-dev -> firefox.tar.bz2' \
  atclone'tar jxf *.tar.bz2; _create_and_link_desktop_file firefox "$(readlink -f firefox/firefox)" firefox; rm *.tar.bz2;' \
  atpull'%atclone'
zplugin snippet "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"

# gitahead
zplugin ice wait lucid from"gh-r" as"program" bpick"*sh"  pick'./GitAhead/GitAhead' \
  atclone'./GitAhead*.sh --include-subdir;' \
  atpull'%atclone'
zplugin light gitahead/gitahead

