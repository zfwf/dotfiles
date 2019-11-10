 # neovim + vim-plug ---------
zplugin ice lucid wait from"gh-r" as"program" bpick"*macos*" \
  atclone'ln -sf ./nvim-osx64/bin/nvim; ' pick"nvim" \
  atpull'%atclone'
zplugin light neovim/neovim

zplugin ice lucid wait as'program' pick'./fpp'
zplugin light facebook/PathPicker

zplugin ice lucid \
  atclone'mkdir -p ~/.local/share/nvim/site/autoload; \
  ln -sf "$PWD/plug.vim" ~/.local/share/nvim/site/autoload/plug.vim' \
  atpull'%atclone'
zplugin light junegunn/vim-plug
# -----------------------------


# fzy
zplugin ice lucid wait"1" as"program" make"!PREFIX=$ZPFX install" \
  atclone"cp contrib/fzy-* $ZPFX/bin/" \
  pick"$ZPFX/bin/fzy*" \
  atpull'%atclone'
zplugin light jhawthorn/fzy

# tmux (require autoconf, automake, pkg-config) + oh-my-tmux (gh-254 branch) + tmux plugin manager
zplugin ice lucid wait as"program" atclone"sh autogen.sh; ./configure --prefix=$ZPFX" \
  make"install" pick"$ZPFX/bin/tmux"
zplugin light tmux/tmux

zplugin ice lucid wait id-as"gpakosz/tmux" ver"gh-254" cp".tmux.conf -> $HOME/" nocompile
zplugin light gpakosz/.tmux

zplugin ice lucid nocompile wait
zplugin light tmux-plugins/tpm
# ------------------------------
