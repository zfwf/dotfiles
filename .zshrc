# command for interactive shell (load order: .zshenv, .zshrc, .zsh)

# init completion
autoload -Uz compinit && compinit

# source inits
[[ -d ~/.config/sh/init-interactive.d ]] && for f (~/.config/sh/init-interactive.d/**/*.sh) . $f

# misc configs
case `uname` in
  Darwin)
    ;;

  Linux)
    ;;
esac



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

# case -insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

# source vendors scripts
[[ -d  ~/.vendors ]] && for f (~/.vendors/**/*.sh(.N)) . $f

# mise
[[ -x "$(command -v mise)" ]] && eval "$(mise activate zsh)" > /dev/null 2>&1

# starship prompt
[[ -x "$(command -v starship)" ]] && eval "$(starship init zsh)" > /dev/null 2>&1


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# AUTOSUGGESTIONS, TRIGGER PRECMD HOOK UPON LOAD
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
zinit ice wait="2" lucid atload="_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit light zdharma-continuum/fast-syntax-highlighting

### End of Zinit's installer chunk



# prepend $HOME/.local/bin
export PATH="$HOME/.local/bin:$PATH"
