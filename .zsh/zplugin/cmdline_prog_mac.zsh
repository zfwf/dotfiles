 # neovim + vim-plug ---------
zplugin ice lucid wait from"gh-r" as"program" bpick"*macos*" \
  atclone'ln -sf ./nvim-osx64/bin/nvim; ' pick"nvim" \
  atpull'%atclone'
zplugin light neovim/neovim

zplugin ice lucid wait \
  atclone'mkdir -p ~/.local/share/nvim/site/autoload; \
  ln -sf "$PWD/plug.vim" ~/.local/share/nvim/site/autoload/plug.vim' \
  atpull'%atclone'
zplugin light junegunn/vim-plug
# -----------------------------


