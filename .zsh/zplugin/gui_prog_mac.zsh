# copy dmg content to current directory
extract_dmg() {
  local dmg_name=$1
  local content=$2
  local dmg_volume=$3

  hdiutil attach $(realpath -m $dmg_name)
  cp -R $(realpath -m $content) .
  hdiutil detach $(realpath -m $dmg_volume)
}

# create alias for spotlight to find apps
create_alias_in_user_applications() {
  local app_path=$(realpath -m $1)
  local user_applications_path=$(realpath -m ~/Applications)
  local script='tell application \"Finder\" to make alias file to \
    POSIX file "$1" at \
    POSIX file "$2"'

  osascript -e "$script" -- "$app_path" "$user_applications_path"
}


# vscode
zplugin ice lucid wait from"gh-r" as"program" bpick"*darwin*.zip" \
  atclone'create_alias_in_user_applications "./VSCodium.app"' \
  sbin'VSCodium.app/Contents/Resources/app/bin/code' pick'/dev/null' \
  atpull'%atclone'
zplugin light VSCodium/vscodium

# gitahead
zplugin ice lucid wait from"gh-r" as"program" bpick"*dmg" \
  atclone'extract_dmg GitAhead*.dmg /Volumes/GitAhead/GitAhead.app /Volumes/GitAhead; \
  create_alias_in_user_applications ./GitAhead.app' \
  sbin'GitAhead.app/Contents/MacOS/GitAhead -> gitahead' pick'/dev/null' \
  atpull'%atclone'
zplugin light gitahead/gitahead

# alacritty
zplugin ice lucid wait from"gh-r" as"program" bpick'*dmg'  \
  atclone'extract_dmg Alacritty*.dmg /Volumes/Alacritty/Alacritty.app "/Volumes/Alacritty"; \
  create_alias_in_user_applications ./Alacritty.app' \
  sbin'Alacritty.app/Contents/MacOS/alacritty' pick'/dev/null' \
  atpull'%atclone'
zplugin light jwilm/alacritty

# sublime text
zplugin ice lucid wait as"program" \
  atclone'extract_dmg Sublime*.dmg /Volumes/Sublime\ Text/Sublime Text.app /Volumes/Sublime\ Text; \
  create_alias_in_user_applications "./Sublime Text.app"' \
  sbin'Sublime Text.app/Contents/MacOS/Sublime Text -> subl' pick'/dev/null' \
  atpull'%atclone'
zplugin snippet https://download.sublimetext.com/Sublime%20Text%20Build%203211.dmg

# azure data studio
zplugin ice lucid wait as"program" \
  atclone'create_alias_in_user_applications "./Azure Data Studio.app"' \
  sbin'Azure Data Studio.app/Contents/MacOS/Electron -> ads' pick'/dev/null' \
  atpull'%atclone'
zplugin snippet https://azuredatastudiobuilds.blob.core.windows.net/releases/1.12.2/azuredatastudio-macos-1.12.2.zip


# ff dev edition
zplugin ice lucid wait as'program' \
  atclone'extract_dmg Firefox*.dmg "/Volumes/Firefox Developer Edition/Firefox Developer Edition.app" "/Volumes/Firefox Developer Edition"; \
  create_alias_in_user_applications "./Firefox Developer Edition.app"' \
  sbin'Firefox Developer Edition.app/Contents/MacOS/firefox' pick'/dev/null' \
  atpull'%atclone'
zplugin snippet https://download-installer.cdn.mozilla.net/pub/devedition/releases/71.0b4/mac/en-US/Firefox%2071.0b4.dmg

# qview
zplugin ice lucid wait as'program' from"gh-r" as"program" bpick'*dmg' \
  atclone'extract_dmg qView*.dmg /Volumes/**/qView.app /Volumes/qView*/; \
  create_alias_in_user_applications "./qView.app"' \
  sbin'qView.app/Contents/MacOS/qView' pick'/dev/null' \
  atpull'%atclone'
zplugin light jurplel/qView
