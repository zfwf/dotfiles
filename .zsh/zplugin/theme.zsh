# theme specific
_config_powerline() {
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
}

# theme
zplugin ice atinit'_config_powerline'; zplugin light romkatv/powerlevel10k

# ls colors
zplugin ice wait"1" lucid
zplugin snippet OMZ::lib/theme-and-appearance.zsh

