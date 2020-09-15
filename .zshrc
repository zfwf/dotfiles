# command for interactive shell (load order: .zshenv, .zshrc, .zsh)


# catalina specific
# strip out /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin and append
export PATH=$(echo $PATH | sed 's/\/usr\/local\/bin:\/usr\/bin:\/bin:\/usr\/sbin:\/sbin//g')
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

export TERM='xterm-256color' # attempt enable at least 256 color

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
autoload -Uz up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N down-line-or-beginning-search

# use jk to go to cmd from ins
bindkey -M viins 'jk' vi-cmd-mode

# Better searching in command mode
bindkey -M vicmd '?' history-incremental-pattern-search-backward
bindkey -M vicmd '/' history-incremental-pattern-search-forward
bindkey -M vicmd "^n" history-incremental-pattern-search-backward
bindkey -M vicmd "^p" history-incremental-pattern-search-forward

bindkey -M viins '^n' history-incremental-pattern-search-backward
bindkey -M viins '^p' history-incremental-pattern-search-forward
# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search

# hide legacy docker commands
export DOCKER_HIDE_LEGACY_COMMANDS=true

# alias
export VISUAL=nvim
export EDITOR="$VISUAL"
alias vi="$VISUAL"
alias top="bottom"
alias react-devtools='npx react-devtools@^3'
alias meta='npx meta'
alias ll='ls -la'
alias cat='bat'

case `uname` in
  Darwin)
    alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'
    alias postgre:start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
    alias postgre:stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
    ;;
  Linux)
    alias ls="exa --color"
    alias trash=gvfs-trash
    ;;
esac

sendsigterm() {
  kill -15 $1
}


pport() {
  lsof -t -i tcp:$1
}

extract-filename() {
  echo $(basename -- $1)
}

extract-filename-wo-ext() {
  echo ${$(extract-filename $1)%.*}
}

co() {
  if [ -z "$4" ]; then
    local cloned_folder=$(extract-filename-wo-ext $2)-$1-$3
    local branch_name=$1/$3
  else
    local cloned_folder=$(extract-filename-wo-ext $2)-$4-$1-$3
    local branch_name=$4/$1/$3
  fi
  command git clone $2 $cloned_folder
  cd $cloned_folder
  if [ -f ".meta" ]; then
    meta git update
    if [ ! -z "$4" ]; then
      meta git checkout master
      meta git update
    fi
    meta git checkout -b $branch_name
    meta exec "git push -u origin $branch_name"
    meta exec 'npm ci'
  else
    command git checkout -b $branch_name
    command git push -u origin $branch_name
    npm ci
    npm run build --if-present
  fi
}

cof-beta() {
  co 'feature' "$@" 'beta'
}

cof() {
  co 'feature' "$@"
}

cob-beta() {
  co 'bugfix' "$@" 'beta'
}

cob() {
  co 'bugfix' "$@"
}

# dotfiles bare repo
CMD_GIT="$(command -v git)"
git() {
  if [[ "$PWD" == "$HOME" ]]; then
    "$CMD_GIT" --git-dir="$HOME"/.cfg/ --work-tree="$HOME" "$@"
  else
    "$CMD_GIT" "$@"
  fi
}

# starship prompt
eval "$(starship init zsh)"
