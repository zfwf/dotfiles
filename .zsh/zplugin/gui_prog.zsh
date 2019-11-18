_create_and_link_desktop_file() {
  local app_dir=$HOME/.local/share/applications
  echo "[Desktop Entry]\nName=$4\nExec=$2 %U\nIcon=$3\nType=Application\nStartupNotify=true" > $1.desktop
  mkdir -p $app_dir
  ln -sf "$(readlink -f $1.desktop)" $app_dir/$1.desktop
}

# vscode
zplugin ice lucid wait from"gh-r" bpick"*tar.gz" mv'codium -> code' as"null" sbin'code'
zplugin light VSCodium/vscodium

# ff dev edition
zplugin ice lucid wait id-as"ff-dev"  \
  mv'ff-dev -> firefox.tar.bz2' \
  atclone'tar jxf *.tar.bz2; _create_and_link_desktop_file firefox "$(readlink -f firefox/firefox)" firefox Firefox; rm *.tar.bz2;' \
  as'null' sbin'firefox/firefox' \
  atpull'%atclone'
zplugin snippet "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"

# gitahead
zplugin ice lucid wait from"gh-r" as"program" bpick"*sh"  pick'./GitAhead/GitAhead' \
  atclone'./GitAhead*.sh --include-subdir;' \
  atpull'%atclone'
zplugin light gitahead/gitahead

# android studio
zplugin ice lucid wait id-as'android-studio-ide' \
  mv'android-studio-ide -> android-studio-ide.tar.gz' \
  atclone'tar xzvf *.tar.gz; _create_and_link_desktop_file android-studio "$(readlink -f android-studio/bin/studio.sh)" AndroidStudio "Android Studio"; rm *.tar.gz' \
  as'null' sbin'android-studio/bin/studio.sh -> android-studio'
zplugin snippet 'https://dl.google.com/dl/android/studio/ide-zips/3.5.2.0/android-studio-ide-191.5977832-linux.tar.gz'

# google chrome
#zplugin ice lucid wait id-as"google-chrome" as'program' pick'chrome/chrome' \
#  mv'google-chrome -> google-chrome.rpm' \
#  atclone'rm -rf chrome; mkdir temp; mv -v *.rpm temp/; cd temp; rpm2cpio *.rpm | cpio -idmv; cd -; mv -v temp/opt/google/chrome ./; rm -rf temp/; \
#  mv -v chrome/google-chrome chrome/launcher;
#  # sudo chown root:root chrome/chrome-sandbox; \
#  # sudo chmod 4755 chrome/chrome-sandbox; \
#  chmod 4755 chrome/chrome-sandbox; \
#  _create_and_link_desktop_file "Google Chrome" "env FONTCONFIG_PATH=/usr/share/defaults/fonts $(readlink -f chrome/chrome)" google-chrome;' \
#  atpull'%atclone'
#zplugin snippet "https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"

