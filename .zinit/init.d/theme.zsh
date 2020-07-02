BASE_THEME=${0:a:h}/themes/p9k-base.zsh
CURRENT_THEME=${0:a:h}/themes/p9kgt.zsh

# theme
zinit ice atinit". $BASE_THEME;. $CURRENT_THEME"; zinit light romkatv/powerlevel10k

# ls colors
zinit ice wait'1' lucid atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

