# bash completion support
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

script_dir=${0:a:h}

# autosuggestions
zinit ice wait'1' silent atload'export ZSH_AUTOSUGGEST_USE_ASYNC=true; _zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

#  completions
zinit ice wait'1' lucid
zinit snippet OMZ::lib/git.zsh

zinit ice wait'1' lucid atinit'ZSH_CACHE_DIR="$HOME/.zcompcache"'
zinit snippet OMZ::lib/history.zsh

zinit ice wait'1' lucid
zinit snippet OMZ::lib/completion.zsh

zinit ice wait'1' lucid atload"unalias grv g"
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice wait'1' lucid as"completion"
zinit snippet OMZ::plugins/docker/_docker

zinit ice wait'1' lucid as"completion"
zinit snippet OMZ::plugins/docker-compose/_docker-compose

zinit ice wait'1' lucid
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh

zinit ice wait'1' blockf lucid
zinit light zsh-users/zsh-completions

