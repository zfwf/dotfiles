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

install_dmg() {
  remove_alias_in_user_applications *.app
  extract_dmg $1
  create_alias_in_user_applications *.app
}

install_dotapp() {
  remove_alias_in_user_applications *.app
  create_alias_in_user_applications *.app
}


# vscode
zplugin ice lucid wait'2' from"gh-r" bpick"*darwin*.zip" \
  atclone'create_alias_in_user_applications *.app' \
  as'null' sbin'VSCodium.app/Contents/Resources/app/bin/code' \
  atpull'%atclone'
zplugin light VSCodium/vscodium

# gitahead
zplugin ice lucid wait'2' from"gh-r" bpick"*dmg" \
  atclone'extract_dmg GitAhead; \
    create_alias_in_user_applications *.app' \
  as'null' sbin'GitAhead.app/Contents/MacOS/GitAhead -> gitahead' \
  atpull'%atclone'
zplugin light gitahead/gitahead

# alacritty
zplugin ice lucid wait'2' from"gh-r" bpick'*dmg'  \
  atclone'extract_dmg Alacritty; \
    create_alias_in_user_applications *.app' \
  as'null' sbin'Alacritty.app/Contents/MacOS/alacritty' \
  atpull'%atclone'
zplugin light jwilm/alacritty

# sublime text
zplugin ice lucid wait'2' id-as"subl" \
  mv'subl -> subl.dmg' \
  atclone'install_dmg "Sublime*"' \
  as'null' sbin'Sublime Text.app/Contents/MacOS/Sublime Text -> subl' \
  atpull'%atclone'
zplugin snippet "https://download.sublimetext.com/Sublime%20Text%20Build%203211.dmg"

# azure data studio
zplugin ice lucid wait'2' id-as'ads' \
  mv'ads -> ads.zip' \
  atclone'unzip ads.zip -d .; install_dotapp' \
  as'null' sbin'Azure Data Studio.app/Contents/MacOS/Electron -> ads' \
  atpull'%atclone'
zplugin snippet "https://go.microsoft.com/fwlink/?linkid=2109180"


# ff dev edition
zplugin ice lucid wait'2' id-as'ff-dev' \
  mv'ff-dev -> ff-dev.dmg' \
  atclone'extract_dmg "Firefox*"; \
    create_alias_in_user_applications *.app' \
  as'null' sbin'Firefox Developer Edition.app/Contents/MacOS/firefox' \
  atpull'%atclone'
zplugin snippet "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=osx&lang=en-US"

# qview
zplugin ice lucid wait'2' from"gh-r" bpick'*dmg' \
  atclone'extract_dmg "qView*"; \
    create_alias_in_user_applications *.app' \
  as'null' sbin'qView.app/Contents/MacOS/qView' \
  atpull'%atclone'
zplugin light jurplel/qView


zplugin ice lucid wait'2' from"gh-r" \
  atclone'install_dmg "meld*"' \
  as'null' sbin'Meld.app/Contents/MacOS/Meld -> meld' \
  atpull'%atclone'
zplugin light yousseb/meld
