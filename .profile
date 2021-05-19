# $HOME/.profile: executed by Bourne-compatible login shells.

# pre-init script
[ -f  $HOME/.pre-init.sh ] && . $HOME/.pre-init.sh

# other paths
[ -f  $HOME/.zinit/paths.sh ] && . $HOME/.zinit/paths.sh


export PATH="$HOME/.poetry/bin:$PATH"
