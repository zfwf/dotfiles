# $HOME/.profile: executed by Bourne-compatible login shells.

# pre-init script
[ -f  $HOME/.pre-init.sh ] && . $HOME/.pre-init.sh

if [ -f  $HOME/.zplugin/plugins/asdf-vm---asdf/asdf.sh ]; then
  . $HOME/.zplugin/plugins/asdf-vm---asdf/asdf.sh
  . $HOME/.asdf/plugins/java/set-java-home.sh
fi

# other paths
[ -f  $HOME/.zsh/paths.sh ] && . $HOME/.zsh/paths.sh

