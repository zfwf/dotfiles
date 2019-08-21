# command for interactive shell (load order: .zshenv, .zshrc, .zsh)

# Returns whether the given command is executable or aliased.

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

# use neovim as editor in general
# export VISUAL=nvim
export VISUAL=nvim
export EDITOR="$VISUAL"
alias vi="$VISUAL"


# alias
alias avd-16="cd $HOME/Android/Sdk/tools; emulator -avd Nexus_4_API_16"
alias avd-21="cd $HOME/Android/Sdk/tools; emulator -avd Nexus_4_API_21"
alias avd-23="cd $HOME/Android/Sdk/tools; emulator -avd Nexus_4_API_23"
alias meta="npx meta"
alias top="npx gtop"

case `uname` in
  Darwin) # commands for OS X go here
    # alias
    alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'
    ;;
  Linux) # commands for Linux go here
    # alias
    alias trash=gvfs-trash
    alias idea=intellij-idea-ultimate # from snap
    ;;
esac
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

