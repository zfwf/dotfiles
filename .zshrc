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

# hide legacy docker commands
export DOCKER_HIDE_LEGACY_COMMANDS=true

# alias
export VISUAL=nvim
export EDITOR="$VISUAL"
alias vi="$VISUAL"
alias top="glances"
alias react-devtools='npx react-devtools@^3'

case `uname` in
  Darwin)
    alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'
    alias postgre:start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
    alias postgre:stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
    ;;
  Linux)
    alias trash=gvfs-trash
    ;;
esac

spackpath() {
  spack find -p $1 | tail -1 | cut -f 7 -d " "
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
  local cloned_folder=$(extract-filename-wo-ext $2)-$1-$3
  local branch_name=$1/$3
  command git clone $2 $cloned_folder
  cd $cloned_folder; command git checkout -b $branch_name
  command git push -u origin $branch_name
  [ -f ./.npmrc ] && sed -i '' -e '$s/^\/\/npm\.pkg\.github\.com/#/' ./.npmrc
  if [ -f ./package-lock.json ]; then
    npm ci
    npm run build --if-present
  elif [ -f ./yarn.lock ]; then
    yarn
    yarn run build --if-present
  fi
}

cof() {
  co 'feature' "$@"
}

cob() {
  co 'bugfix' "$@"
}

# dotfiles bare repo
git() {
  if [[ "$PWD" == "$HOME" ]]; then
    command git --git-dir="$HOME"/.cfg/ --work-tree="$HOME" "$@"
  else
    command git "$@"
  fi
}
