_create_and_link_desktop_file() {
  local app_dir=$HOME/.local/share/applications
  echo "[Desktop Entry]\nName=$4\nExec=$2 %U\nIcon=$3\nType=Application\nStartupNotify=true" > $1.desktop
  mkdir -p $app_dir
  ln -sf "$(readlink -f $1.desktop)" $app_dir/$1.desktop
}

# vscode
zinit ice lucid from"gh-r" bpick"*x64*" \
  atclone'_create_and_link_desktop_file vscodium "$(readlink -f codium)" "$(readlink -f resources/app/resources/linux/code.png)"  VSCodium' \
  atpull'%atclone' \
  as"null" sbin'**/codium -> code'
zinit light VSCodium/vscodium

# gitahead
zinit ice lucid from"gh-r" bpick"*sh"\
  atclone'./GitAhead*.sh --include-subdir;' \
  atpull'%atclone' \
  as"null"  sbin'**/GitAhead -> gitahead'
zinit light gitahead/gitahead

# azure data studio
zinit ice lucid id-as'azure-data-studio' \
  mv'azure-data-studio -> azure-data-studio.tar.gz' \
  atclone'tar xzvf azure-data-studio.tar.gz;  _create_and_link_desktop_file azure-data-studio "$(readlink -f azuredatastudio-linux-x64/azuredata-studio)" "$(readlink -f azuredatastudio-linux-x64/resources/app/resources/linux/code.png)" "Azure Data Studio"; rm *.tar.gz' \
  atpull'%atclone' \
  as'null' sbin'**/azuredata-studio -> azure-data-studio'
zinit snippet "https://go.microsoft.com/fwlink/?linkid=2109179"

# android studio
zinit ice lucid id-as'android-studio-ide' \
  mv'android-studio-ide -> android-studio-ide.tar.gz' \
  atclone'tar xzvf *.tar.gz; _create_and_link_desktop_file android-studio "$(readlink -f android-studio/bin/studio.sh)" "$(readlink -f android-studio/bin/studio.png)" "Android Studio"; rm *.tar.gz' \
  atpull'%atclone' \
  as'null' sbin'**/studio.sh -> android-studio'
zinit snippet 'https://dl.google.com/dl/android/studio/ide-zips/3.5.2.0/android-studio-ide-191.5977832-linux.tar.gz'

# ff dev edition
zinit ice lucid id-as"ff-dev"  \
  mv'ff-dev -> firefox.tar.bz2' \
  atclone'tar jxf *.tar.bz2; _create_and_link_desktop_file firefox "$(readlink -f firefox/firefox)" firefox Firefox; rm *.tar.bz2;' \
  atpull'%atclone' \
  as'null' sbin'**/firefox'
zinit snippet "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"

# google chrome
#zinit ice lucid wait id-as"google-chrome" as'program' pick'chrome/chrome' \
#  mv'google-chrome -> google-chrome.rpm' \
#  atclone'rm -rf chrome; mkdir temp; mv -v *.rpm temp/; cd temp; rpm2cpio *.rpm | cpio -idmv; cd -; mv -v temp/opt/google/chrome ./; rm -rf temp/; \
#  mv -v chrome/google-chrome chrome/launcher;
#  # sudo chown root:root chrome/chrome-sandbox; \
#  # sudo chmod 4755 chrome/chrome-sandbox; \
#  chmod 4755 chrome/chrome-sandbox; \
#  _create_and_link_desktop_file "Google Chrome" "env FONTCONFIG_PATH=/usr/share/defaults/fonts $(readlink -f chrome/chrome)" google-chrome;' \
#  atpull'%atclone'
#zinit snippet "https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"

