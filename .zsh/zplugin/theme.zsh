BASE_THEME=${0:a:h}/themes/p9k-base.zsh
CURRENT_THEME=${0:a:h}/themes/p9kgt.zsh

# theme
zinit ice atinit". $BASE_THEME;. $CURRENT_THEME"; zinit light romkatv/powerlevel10k

# ls colors
zinit ice wait'3' lucid
zinit snippet OMZ::lib/theme-and-appearance.zsh

