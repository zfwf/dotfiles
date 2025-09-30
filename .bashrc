shopt -s globstar # enable recursive globbing
shopt -s nullglob # enable nullglob to avoid errors with empty globs

# source inits
[[ -d ~/.config/sh/init-interactive.d ]] && for f in ~/.config/sh/init-interactive.d/**/*.sh; do . $f; done

# set some history options
shopt -s histappend

# Keep a ton of history.
HISTSIZE=99999
SAVEHIST=99999
HISTFILE=$HOME/.bash_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# hide user in shell prompt
export DEFAULT_USER="$USER"

# set vi mode
set -o vi
bind '"jk":vi-movement-mode'

# source vendor scripts
[[ -d ~/.vendor ]] && for f in ~/.vendor/**/*.sh; do . $f; done


# starship prompt
[[ -x "$(command -v starship)" ]] && eval "$(starship init bash)" > /dev/null 2>&1

[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

