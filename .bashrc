# Use global profile when available
if [ -f /usr/share/defaults/etc/profile ]; then
	. /usr/share/defaults/etc/profile
fi

# allow admin overrides
if [ -f /etc/profile ]; then
	. /etc/profile
fi

# allow user overrides
if [ -f ~/.profile ]; then
	. ~/.profile
fi

# load orbiter
if ( type orbiter > /dev/null ); then
  # create script in ${HOME}/.cache
  eval "$(orbiter init bash)" > /dev/null 2>&1

  local orbiter_bin_path="$ORBITER_CONST[BIN_DIR]"
  local orbiter_dashboard_bin_path="$ORBITER_CONST[DASHBOARD_BIN_DIR]"
  local stripper=$(get_path_stripper $orbiter_dashboard_bin_path)

  export PATH=$(strip_then_prepend "$PATH" \
    "$(get_path_stripper $orbiter_dashboard_bin_path)" \
    "$orbiter_dashboard_bin_path")
  export PATH=$(strip_then_prepend "$PATH" \
    "$(get_path_stripper $orbiter_bin_path)" \
    "$orbiter_bin_path")

fi



export TERM='xterm-256color' # attempt enable at least 256 color
export GPG_TTY=$TTY

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


# dotfiles bare repo
CMD_GIT="$(command -v git)"
git() {
  local CMD_GIT_EXTRA_ARGS=()
  if [[ "$1" == "push" && "$@" != *"--help"* ]]; then
    CMD_GIT_EXTRA_ARGS=(-u)
  fi

  if [[ "$PWD" == "$HOME" ]]; then
    CMD_GIT_ARGS=(--git-dir="$HOME"/.cfg/ --work-tree="$HOME")
    "$CMD_GIT" "${CMD_GIT_ARGS[@]}" "$@" "${CMD_GIT_EXTRA_ARGS[@]}"
  else
    "$CMD_GIT" "$@" "${CMD_GIT_EXTRA_ARGS[@]}"
  fi
}

# alias
alias npx='npm_config_yes=true npx'

# git aliases
alias gst='git status'
alias gco='git checkout'
alias ga='git add'
alias gl='git pull'
alias gp='git push'
alias grb='git rebase'
alias gc='git commit -v'
alias gcam='git commit -avm'
alias gcan!='git commit -v -a --no-edit --amend'
alias gsta='git stash'
alias gchp='git cherry-pick'
alias gpf='git push --force-with-lease'


eval "$(starship init bash)" > /dev/null 2>&1
