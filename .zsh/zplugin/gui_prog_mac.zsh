# copy dmg content to current directory
extract_dmg() {
  local dmg_name="*.dmg"
  local content="/Volumes/**/*.app"
  local dmg_volume=$1

  local attached_vol=$(eval "hdiutil attach $(realpath -m $dmg_name)" | tail -n1 | cut -f 3)
  eval "cp -r $(realpath -m $content) ."
  echo "att vol $(realpath -m $attached_vol)"
  eval "hdiutil detach \"$attached_vol\""
}

# create alias for spotlight to find apps
remove_alias_in_user_applications() {
  local app_path=$(realpath -m $1)
  local app_name=${$(basename $app_path)%.*}
  local user_applications_path=$(realpath -m ~/Applications)

  eval "rm -f '$user_applications_path/$app_name'*"; # remove old alias
}


# create alias for spotlight to find apps
create_alias_in_user_applications() {
  local app_path=$(realpath -m $1)
  local app_name=${$(basename $app_path)%.*}
  local user_applications_path=$(realpath -m ~/Applications)
  local script="tell application \"Finder\" to make alias file to \
    POSIX file \"$app_path\" at \
    POSIX file \"$user_applications_path\""

  osascript -e "$script"
}

install_dotapp() {
  remove_alias_in_user_applications *.app
  create_alias_in_user_applications *.app
}

install_dmg() {
  extract_dmg $1
  install_dotapp
}


# vscode
zplugin ice lucid wait'2' from"gh-r" bpick"*darwin*.zip" \
  atclone'install_dotapp' \
  atpull'%atclone' \
  as'null' sbin'**/code'
zplugin light VSCodium/vscodium

# gitahead
zplugin ice lucid wait'2' from"gh-r" bpick"*dmg" \
  atclone'install_dmg GitAhead' \
  atpull'%atclone' \
  as'null' sbin'**/GitAhead -> gitahead'
zplugin light gitahead/gitahead

# alacritty
zplugin ice lucid wait'2' from"gh-r" bpick'*dmg'  \
  atclone'install_dmg Alacritty' \
  atpull'%atclone' \
  as'null' sbin'**/alacritty'
zplugin light jwilm/alacritty

# sublime text
zplugin ice lucid wait'2' id-as"subl" \
  mv'subl -> subl.dmg' \
  atclone'install_dmg "Sublime*"' \
  atpull'%atclone' \
  as'null' sbin'**/Sublime\ Text -> subl'
zplugin snippet "https://download.sublimetext.com/Sublime%20Text%20Build%203211.dmg"

# azure data studio
zplugin ice lucid wait'2' id-as'azure-data-studio' \
  mv'azure-data-studio -> azure-data-studio.zip' \
  atclone'unzip azure-data-studio.zip -d .; install_dotapp' \
  atpull'%atclone' \
  as'null' sbin'**/Electron -> ads'
zplugin snippet "https://go.microsoft.com/fwlink/?linkid=2109180"

# ff dev edition
zplugin pack"bgn" for firefox-dev

#meld
zplugin ice lucid wait'2' from"gh-r" \
  atclone'install_dmg "meld*"' \
  atpull'%atclone' \
  as'null' sbin'**/Meld -> meld'
zplugin light yousseb/meld


# qview
zplugin ice lucid wait'2' from"gh-r" bpick'*dmg' \
  atclone'extract_dmg "qView*"; \
    create_alias_in_user_applications *.app' \
  atpull'%atclone' \
  as'null' sbin'**/qView'
zplugin light jurplel/qView

