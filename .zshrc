# command for interactive shell (load order: .zshenv, .zshrc, .zsh)

get_path_stripper() {
  local stripper="s/$(echo $1 | sed 's/\//\\\//g')//g"

  echo $stripper
}

strip_then_prepend() {
  local stripped=$(echo $1 | sed $2)

  echo "$3:$stripped"
}

strip_then_append() {
  local stripped=$(echo $1 | sed $2)

  echo "$stripped:$3"
}

# load orbiter
. ~/orbiter_init.zsh

# misc configs
case `uname` in
  Darwin)
    # catalina specific
    local system_usr_bin_dir_paths='/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
    export PATH=$(strip_then_append "$PATH" \
      $(get_path_stripper $system_usr_bin_dir_paths) \
      $system_usr_bin_dir_paths)
    ;;

  Linux)
    ;;
esac

# add .local/bin
export PATH=$(strip_then_append "$PATH" \
  $(get_path_stripper "$HOME/.local/bin") \
  "$HOME/.local/bin")



export TERM='xterm-256color' # attempt enable at least 256 color
export GPG_TTY=$TTY

# set some history options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify

setopt share_history            # Share your history across all your terminal windows
setopt pushd_ignore_dups        # ignore dup in dir stack
unsetopt beep                   # no bell on error
unsetopt hist_beep              # no bell on error in history
unsetopt list_beep              # no bell on ambiguous completion
unsetopt bg_nice                # no lower prio for background jobs

# Keep a ton of history.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=$HOME/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"


# hide user in shell prompt
export DEFAULT_USER="$USER"

# use $PWD for terminal windows title
case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;$PWD\a"}
        ;;
esac

# zle config
bindkey -v # vi mode, bind alt/opt to escape for easy transition to insert mode 
# 10ms for keybinding to work
export KEYTIMEOUT=10
function zle-keymap-select zle-line-init
{
       # change cursor shape in xterm
       case $KEYMAP in
               vicmd)      echo -e -n "\x1b[\x32 q";;  # block cursor
               viins|main) echo -e -n "\x1b[\x35 q";;  # blinking line cursor
       esac

       zle reset-prompt
       zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select

# load zle history widgets

# use jk to go to cmd from ins
bindkey -M viins 'jk' vi-cmd-mode

# Better searching in command mode
bindkey -M vicmd '?' history-incremental-pattern-search-backward
bindkey -M vicmd '/' history-incremental-pattern-search-forward
bindkey -M vicmd "^n" history-incremental-pattern-search-backward
bindkey -M vicmd "^p" history-incremental-pattern-search-forward

bindkey -M viins '^n' history-incremental-pattern-search-backward
bindkey -M viins '^p' history-incremental-pattern-search-forward

# Beginning search with up keys
autoload -Uz up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
# Beginning search with down keys
autoload -Uz down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# hide legacy docker commands
export DOCKER_HIDE_LEGACY_COMMANDS=true

sendsigterm() {
  kill -15 $1
}


pport() {
  lsof -t -i tcp:$1
}


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

case `uname` in
  Darwin)
    ;;
  Linux)
    alias trash=gvfs-trash
    ;;
esac



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

# case -insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# source vendor scripts
[ -d  ~/.vendor ] && for f (~/.vendor/**/*.zsh) . $f

# starship prompt
eval "$(starship init zsh)" > /dev/null 2>&1

