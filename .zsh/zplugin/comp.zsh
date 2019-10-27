script_dir=${0:a:h}

# autosuggestions
zplugin ice wait silent atload'export ZSH_AUTOSUGGEST_USE_ASYNC=true; _zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions

#  completions
zplugin ice wait lucid
zplugin snippet OMZ::lib/git.zsh

zplugin ice lucid atinit'ZSH_CACHE_DIR="$HOME/.zcompcache"'
zplugin snippet OMZ::lib/history.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/completion.zsh

zplugin ice wait lucid atload"unalias grv g"
zplugin snippet OMZ::plugins/git/git.plugin.zsh

zplugin ice wait lucid as"completion"
zplugin snippet OMZ::plugins/docker/_docker

zplugin ice wait lucid as"completion"
zplugin snippet OMZ::plugins/docker-compose/_docker-compose

zplugin ice wait lucid
zplugin snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh

zplugin ice wait blockf lucid
zplugin light zsh-users/zsh-completions

