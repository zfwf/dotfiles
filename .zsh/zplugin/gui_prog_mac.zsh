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


# vscode
zinit ice lucid from"gh-r" bpick"*darwin*.zip" \
  atclone'install_dotapp' \
  atpull'%atclone' \
  as'null' sbin'**/bin/code'
zinit light VSCodium/vscodium

# gitahead
zinit ice lucid from"gh-r" bpick"*dmg" \
  atclone'install_dotapp' \
  atpull'%atclone' \
  as'null' sbin'**/GitAhead -> gitahead'
zinit light gitahead/gitahead

# alacritty
zinit ice lucid from"gh-r" bpick"*dmg" \
  atclone'install_dotapp' \
  atpull'%atclone' \
  as'null' sbin'**/alacritty'
zinit light alacritty/alacritty

# sublime text
zinit ice lucid id-as"subl" \
  mv'subl -> subl.dmg' \
  atclone'install_dotapp' \
  atpull'%atclone' \
  as'null' sbin'**/Sublime\ Text -> subl'
zinit snippet "https://download.sublimetext.com/Sublime%20Text%20Build%203211.dmg"

# azure data studio
zinit ice lucid id-as'azure-data-studio' \
  mv'azure-data-studio -> azure-data-studio.zip' \
  atclone'unzip azure-data-studio.zip -d .; install_dotapp' \
  atpull'%atclone' \
  as'null' sbin'**/Electron -> ads'
zinit snippet "https://go.microsoft.com/fwlink/?linkid=2109180"

# ff dev edition
zinit pack"bgn" for firefox-dev

#meld
zinit ice lucid from"gh-r" \
  atclone'install_dotapp' \
  atpull'%atclone' \
  as'null' sbin'**/Meld -> meld'
zinit light yousseb/meld


# qview
zinit ice lucid from"gh-r" bpick'*dmg' \
  atclone'install_dotapp' \
  atpull'%atclone' \
  as'null' sbin'**/qView'
zinit light jurplel/qView

