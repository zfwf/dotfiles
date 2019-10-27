# ~/.profile: executed by Bourne-compatible login shells.

if [ -f  ~/.zplugin/plugins/asdf-vm---asdf/asdf.sh ]; then
  . ~/.zplugin/plugins/asdf-vm---asdf/asdf.sh
  . ~/.asdf/plugins/java/set-java-home.sh
fi

# other paths
. ~/.zsh/paths.sh

