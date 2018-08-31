# command for interactive shell (load order: .zshenv, .zshrc, .zsh)

# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

export TERM='xterm-256color'
# theme specific
## if using awesome font-config
#POWERLEVEL9K_MODE='awesome-fontconfig'
## if using nerd font
POWERLEVEL9K_MODE='nerdfont-fontconfig'

# disable auto window title
#DISABLE_AUTO_TITLE="true"

# Disable dir/git icons
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=''
POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''

POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'

POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time)

POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4

#python format: http://strftime.org/
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S}"

# = 0 to always print
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1

POWERLEVEL9K_STATUS_VERBOSE=false


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
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# disable permission check for completion
ZSH_DISABLE_COMPFIX=true

# load zgen
source "${HOME}/.zgen/zgen.zsh"

load-starter-list() {
  # specify oh-my-zsh plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/python
  zgen oh-my-zsh plugins/command-not-found

  # history substring search must come after syntax highlighting
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting

  # theme
  zgen load bhilburn/powerlevel9k powerlevel9k

  # generate the init script from plugins above
  zgen save
}

# if the init scipt doesn't exist
if ! zgen saved; then
  load-starter-list
fi


# hide user in shell prompt
export DEFAULT_USER="$USER"

# use $PWD for terminal windows title
case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;$PWD\a"}
        ;;
esac

# zle config
bindkey -v # vi mode
export KEYTIMEOUT=1 # mode change timeout = 0.1sec
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

# node version manager
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi


# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias fzfp="fzf --preview '[[ \$(file --mime {}) =~ binary ]] &&
                  echo {} is a binary file ||
                 (highlight -O ansi -l {} ||
                  coderay {} ||
                  rougify {} ||
                  cat {}) 2>/dev/null | head -500'"
# <c-p> to edit file from fzf in vi
bindkey -s '^p' 'vi $(fzfp)^M'
# fzf + rg configuration
if _has fzf && _has rg; then
  export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude ".git" --exclude "node_modules" --exclude "vendor"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude ".git" --exclude "node_modules" --exclude "vendor"'
  export FZF_DEFAULT_OPTS='
    --inline-info
    --color fg:242,bg:233,hl:65,fg+:15,bg+:234,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# java
if [ -d "/usr/lib/jvm/default-java" ]; then
  export JAVA_HOME=/usr/lib/jvm/default-java
  export JRE_HOME=$JAVA_HOME/jre
elif [ -d "~/.brew/opt/adoptopenjdk-openjdk8" ]; then
  export JAVA_HOME=~/.brew/opt/adoptopenjdk-openjdk8  
  export JRE_HOME=$JAVA_HOME/jre
fi

# android
if [ -d "$HOME/Android/Sdk" ]; then
  export ANDROID_HOME=$HOME/Android/Sdk
  if [ -d "$ANDROID_HOME/ndk_bundle" ]; then
    export NDK_ROOT=$ANDROID_HOME/ndk_bundle
    export ANDROID_NDK_HOME=$NDK_ROOT
  fi
  PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin
fi

# yarn installed binaries
if [ -d "$HOME/.yarn/bin" ]; then
  PATH=$PATH:$HOME/.yarn/bin
fi

# add cargo (rust) 
if [ -d "$HOME/.cargo/bin" ]; then
  PATH=$HOME/.cargo/bin:$PATH
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# use neovim as editor in general
export VISUAL=nvim
export EDITOR="$VISUAL"
alias vi=nvim

# brew
PATH="$HOME/.brew/bin:$PATH"
export MANPATH="$(brew --prefix)/share/man:$MANPATH"
export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"

# python pip user install
PATH="$PATH:$HOME/Library/Python/3.7/bin" 

# alias
alias trash=gvfs-trash
alias avd-16="cd ~/Android/Sdk/tools; emulator -avd Nexus_4_API_16"
alias avd-21="cd ~/Android/Sdk/tools; emulator -avd Nexus_4_API_21"
alias avd-23="cd ~/Android/Sdk/tools; emulator -avd Nexus_4_API_23"
