# common gui prog


# mac utils
# copy dmg content to current directory
_extract_dmg() {
  local dmg_name="*.dmg"
  local content="/Volumes/**/*.app"

  local attached_vol=$(eval "hdiutil attach $(realpath -m $dmg_name)" | tail -n1 | cut -f 3)
  eval "cp -r $(realpath -m $content) ."
  echo "att vol $(realpath -m $attached_vol)"
  eval "hdiutil detach \"$attached_vol\""
}

# create alias for spotlight to find apps
_remove_alias_in_user_applications() {
  local app_path=$(realpath -m $1)
  local app_name=${$(basename $app_path)%.*}
  local user_applications_path=$(realpath -m ~/Applications)

  eval "rm -f '$user_applications_path/$app_name'*"; # remove old alias
}


# create alias for spotlight to find apps
_create_alias_in_user_applications() {
  local app_path=$(realpath -m $1)
  local app_name=${$(basename $app_path)%.*}
  local user_applications_path=$(realpath -m ~/Applications)
  local script="tell application \"Finder\" to make alias file to \
    POSIX file \"$app_path\" at \
    POSIX file \"$user_applications_path\""

  osascript -e "$script"
}

_install_dotapp() {
  _remove_alias_in_user_applications *.app
  _create_alias_in_user_applications *.app
}

# gnome utils
_create_and_link_desktop_file() {
  local app_dir=$HOME/.local/share/applications
  echo "[Desktop Entry]\nName=$4\nExec=$2 %U\nIcon=$3\nType=Application\nStartupNotify=false\nMimeType=$5" > $1.desktop
  mkdir -p $app_dir
  ln -sf "$(readlink -f $1.desktop)" $app_dir/$1.desktop
}


_integrate_sys() {
  case `uname` in
    Darwin)
      _install_dotapp
      ;;
    Linux)
      _create_and_link_desktop_file $1 $2 $3 $4
      ;;
  esac

}


case `uname` in
  Darwin)
    # vscode
    zinit ice lucid wait"3" id-as'vscode' \
      mv'vscode -> vscode.zip' \
      atclone'unzip vscode.zip -d .; rm *.zip; _install_dotapp;' \
      atpull'%atclone' \
      as'null' sbin'**/Electron -> code'
    zinit snippet 'https://go.microsoft.com/fwlink/?LinkID=620882'

    # ff-dev
    zinit ice lucid wait"3" id-as'firefox-dev' \
      mv'firefox-dev -> firefox.dmg' \
      atclone'_extract_dmg; _install_dotapp' \
      atpull'%atclone' \
      as'null' sbin'**/firefox-bin -> firefox'
    zinit snippet 'https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=osx&lang=en-US'

    # gitahead
    zinit ice lucid wait"3" from"gh-r" bpick"*dmg" \
      atclone'_install_dotapp' \
      atpull'%atclone' \
      as'null' sbin'**/GitAhead -> gitahead'
    zinit light gitahead/gitahead

    # alacritty
    zinit ice lucid wait"3" from"gh-r" bpick"*dmg" \
      atclone'_install_dotapp' \
      atpull'%atclone' \
      as'null' sbin'**/alacritty'
    zinit light alacritty/alacritty

    # sublime text
    zinit ice lucid wait"3" id-as"subl" \
      mv'subl -> subl.dmg' \
      atclone'_install_dotapp' \
      atpull'%atclone' \
      as'null' sbin'**/Sublime\ Text -> subl'
    zinit snippet "https://download.sublimetext.com/Sublime%20Text%20Build%203211.dmg"

    # azure data studio
    zinit ice lucid wait"3" id-as'azure-data-studio' \
      mv'azure-data-studio -> azure-data-studio.zip' \
      atclone'unzip azure-data-studio.zip -d .; _install_dotapp' \
      atpull'%atclone' \
      as'null' sbin'**/Electron -> ads'
    zinit snippet "https://go.microsoft.com/fwlink/?linkid=2109180"

    # meld
    zinit ice lucid wait"3" from"gh-r" \
      atclone'_install_dotapp' \
      atpull'%atclone' \
      as'null' sbin'**/Meld -> meld'
    zinit light yousseb/meld

    # qview
    zinit ice lucid wait"3" from"gh-r" bpick'*dmg' \
      atclone'_install_dotapp' \
      atpull'%atclone' \
      as'null' sbin'**/qView'
    zinit light jurplel/qView

    # hyper
    zinit ice lucid wait"3" from"gh-r" bpick'*dmg' \
      atclone'_install_dotapp' \
      atpull'%atclone' \
      as'null' sbin'**/Hyper -> hyper'
    zinit light zeit/hyper
    ;;
  Linux)
    # vscode
    zinit ice lucid wait"3" id-as'vscode' \
      mv'vscode -> vscode.tar.gz' \
      atclone'tar xzvf vscode.tar.gz; \
      zinit_app_exec=$(readlink -f VSCode-linux-x64/bin/code); \
      zinit_app_icon=vscode; \
      _create_and_link_desktop_file vscode "$zinit_app_exec" "$zinit_app_icon" "Visual Studio Code"; \
      rm *.tar.gz' \
      atpull'%atclone' \
      as'null' sbin'**/bin/code'
    zinit snippet 'https://go.microsoft.com/fwlink/?LinkID=620884'

    # gitahead
    zinit ice lucid wait"3" from"gh-r" bpick"*sh"\
      atclone'./GitAhead*.sh --include-subdir;' \
      atpull'%atclone' \
      as"null"  sbin'**/GitAhead -> gitahead'
    zinit light gitahead/gitahead

    # azure data studio
    zinit ice lucid wait"3" id-as'azure-data-studio' \
      mv'azure-data-studio -> azure-data-studio.tar.gz' \
      atclone'tar xzvf azure-data-studio.tar.gz; \
      zinit_app_exec=$(readlink -f azuredatastudio-linux-x64/azuredata-studio); \
      zinit_app_icon=$(readlink -f azuredatastudio-linux-x64/resources/app/resources/linux/code.png); \
      _create_and_link_desktop_file azure-data-studio "$zinit_app_exec" "$zinit_app_icon" "Azure Data Studio"; \
      rm *.tar.gz' \
      atpull'%atclone' \
      as'null' sbin'**/azuredata-studio -> azure-data-studio'
    zinit snippet "https://go.microsoft.com/fwlink/?linkid=2109179"

    # android studio
    zinit ice lucid wait"3" id-as'android-studio-ide' \
      mv'android-studio-ide -> android-studio-ide.tar.gz' \
      atclone'tar xzvf *.tar.gz; \
      zinit_app_exec=$(readlink -f android-studio/bin/studio.sh); \
      zinit_app_icon=$(readlink -f android-studio/bin/studio.png); \
      _create_and_link_desktop_file android-studio "$zinit_app_exec" "$zinit_app_icon" "Android Studio"' \
      atpull'%atclone' \
      as'null' sbin'**/studio.sh -> android-studio'
    zinit snippet 'https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.0.0.16/android-studio-ide-193.6514223-linux.tar.gz'

    # postman
    zinit ice lucid wait"3" id-as'postman' \
      mv'postman -> postman.tar.gz' \
      atclone'tar xzvf *.tar.gz; \
      zinit_app_exec=$(readlink -f Postman/Postman); \
      _create_and_link_desktop_file postman "$zinit_app_exec" "postman" "Postman"' \
      atpull'%atclone' \
      as'null' sbin'**/Postman -> postman'
    zinit snippet 'https://dl.pstmn.io/download/latest/linux64'

    # zoom
    zinit ice lucid wait"3" id-as'zoom' \
      mv'zoom -> zoom.tar.xz' \
      atclone'tar xvf *.tar.xz; \
      zinit_app_exec=$(readlink -f zoom/ZoomLauncher); \
      _create_and_link_desktop_file zoom "env QT_SCALE_FACTOR=2 $zinit_app_exec" "Zoom" "Zoom" "x-scheme-handler/zoommtg;x-scheme-handler/zoomus;x-scheme-handler/tel;x-scheme-handler/callto;x-scheme-handler/zoomphonecall;application/x-zoom"' \
      atpull'%atclone' \
      as'null' sbin'**/ZoomLauncher -> zoom'
    zinit snippet https://zoom.us/client/latest/zoom_x86_64.tar.xz

    # ff nightly
    zinit ice lucid id-as"ff-nightly"  \
      mv'ff-nightly -> firefox.tar.bz2' \
      atclone'tar jxf *.tar.bz2; _create_and_link_desktop_file firefox "env GDK_BACKEND=wayland $(readlink -f firefox/firefox)" firefox Firefox; rm *.tar.bz2;' \
      atpull'%atclone' \
      as'null' sbin'**/firefox'
    zinit snippet "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US"

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
    ;;
  esac
