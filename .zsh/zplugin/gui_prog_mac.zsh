
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


# meld
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

