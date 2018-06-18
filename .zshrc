# command for interactive shell (load order: .zshenv, .zshrc, .zsh)

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

# Share your history across all your terminal windows
setopt share_history
#setopt noclobber

# set some more options
setopt pushd_ignore_dups
#setopt pushd_silent

# Keep a ton of history.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

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
  zgen load zsh-users/zsh-history-substring-search

  # Set keystrokes for substring searching
  zmodload zsh/terminfo
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down

  # color in dir listing
  zgen load supercrabtree/k

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
# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

# fzf + ag configuration
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='
  --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '
fi


# alias
alias trash=gvfs-trash
alias avd-16="cd ~/Android/Sdk/tools; emulator -avd Nexus_4_API_16"
alias avd-21="cd ~/Android/Sdk/tools; emulator -avd Nexus_4_API_21"
alias avd-23="cd ~/Android/Sdk/tools; emulator -avd Nexus_4_API_23"

