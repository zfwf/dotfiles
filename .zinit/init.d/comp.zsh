# bash completion support
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

script_dir=${0:a:h}

# autosuggestions
zinit ice wait'1' silent atload'export ZSH_AUTOSUGGEST_USE_ASYNC=true; _zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

#  completions
zinit ice wait'1' lucid atload"unalias grv g"
zinit snippet OMZP::git

