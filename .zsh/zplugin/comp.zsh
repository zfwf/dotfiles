script_dir=${0:a:h}

# autosuggestions
zinit ice wait silent atload'export ZSH_AUTOSUGGEST_USE_ASYNC=true; _zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

#  completions
zinit ice wait lucid
zinit snippet OMZ::lib/git.zsh

zinit ice lucid atinit'ZSH_CACHE_DIR="$HOME/.zcompcache"'
zinit snippet OMZ::lib/history.zsh

zinit ice wait lucid
zinit snippet OMZ::lib/completion.zsh

zinit ice wait lucid atload"unalias grv g"
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice wait lucid as"completion"
zinit snippet OMZ::plugins/docker/_docker

zinit ice wait lucid as"completion"
zinit snippet OMZ::plugins/docker-compose/_docker-compose

zinit ice wait lucid
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh

zinit ice wait blockf lucid
zinit light zsh-users/zsh-completions

