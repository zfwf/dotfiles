# git diff
zinit ice lucid as"null" sbin"bin/diff-so-fancy; bin/git-dsf;"
zinit light zdharma/zsh-diff-so-fancy

# file navigation -------------
# rg
zinit ice lucid from"gh-r" as'null' sbin'ripgrep*/rg'
zinit light BurntSushi/ripgrep

# fzf
zinit pack"bgn-binary+keys" for fzf

# -----------------------------
# tmux + oh-my-tmux (nb use ver"gh-254" for tmux 3.0+) + tmux plugin manager
zinit ice lucid make as"null" sbin"tmux" \
  atclone'./autogen.sh; ./configure' \
  atpull'%atclone'
zinit light tmux/tmux

zinit ice lucid wait id-as'gpakosz/tmux' nocompile \
  atclone'ln -sf $PWD/.tmux.conf $HOME/.tmux.conf' \
  atplull'%atclone'
zinit light gpakosz/.tmux

zinit ice lucid wait nocompile
zinit light tmux-plugins/tpm
# -----------------------------


 # neovim + vim-plug ---------
zinit ice lucid wait from"gh-r" as"null" sbin"nvim*/bin/nvim"
zinit light neovim/neovim

zinit ice lucid wait \
  atclone'mkdir -p ~/.local/share/nvim/site/autoload; \
  ln -sf "$PWD/plug.vim" ~/.local/share/nvim/site/autoload/plug.vim' \
  atpull'%atclone'
zinit light junegunn/vim-plug
# -----------------------------




