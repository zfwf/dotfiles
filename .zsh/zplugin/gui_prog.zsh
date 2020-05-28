# common gui prog


# mac utils
# copy dmg content to current directory
_extract_dmg() {
  local dmg_name="*.dmg"
  local content="/Volumes/**/*.app"
  local dmg_volume=$1

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
  remove_alias_in_user_applications *.app
  create_alias_in_user_applications *.app
}

# gnome utils
_create_and_link_desktop_file() {
  local app_dir=$HOME/.local/share/applications
  echo "[Desktop Entry]\nName=$4\nExec=$2 %U\nIcon=$3\nType=Application\nStartupNotify=false" > $1.desktop
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


# ff dev edition
zinit ice lucid wait'3' pack"bgn" atclone+'_integrate_sys firefox "env GDK_BACKEND=wayland $(readlink -f firefox-bin)" firefox Firefox' for firefox-dev


case `uname` in
  Darwin)
    # vscode
    zinit ice lucid wait"3" from"gh-r" bpick"*darwin*.zip" \
      atclone'_install_dotapp' \
      atpull'%atclone' \
      as'null' sbin'**/bin/code'
    zinit light VSCodium/vscodium

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
    zinit ice lucid wait"3" from"gh-r" bpick"*x64*" \
      atclone'zinit_app_exec=$(readlink -f codium); \
      zinit_app_icon=$(readlink -f resources/app/resources/linux/code.png); \
      _create_and_link_desktop_file vscodium "$zinit_app_exec" "$zinit_app_icon" VSCodium' \
      atpull'%atclone' \
      as"null" sbin'**/bin/codium -> code'
    zinit light VSCodium/vscodium

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
    zinit snippet 'https://dl.google.com/dl/android/studio/ide-zips/3.5.2.0/android-studio-ide-191.5977832-linux.tar.gz'

    # postman
    zinit ice lucid wait"3" id-as'postman' \
      mv'postman -> postman.tar.gz' \
      atclone'tar xzvf *.tar.gz; \
      zinit_app_exec=$(readlink -f Postman/Postman); \
      _create_and_link_desktop_file postman "$zinit_app_exec" "postman" "Postman"' \
      atpull'%atclone' \
      as'null' sbin'**/Postman -> postman'
    zinit snippet 'https://dl.pstmn.io/download/latest/linux64'

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
