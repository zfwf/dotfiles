# neovim + vim-plug
zplugin ice wait lucid from"gh-r" as"program" bpick"*appimage*" mv"nvim* -> nvim" pick"nvim"
zplugin light neovim/neovim

zplugin ice wait lucid \
  atclone'mkdir -p ~/.local/share/nvim/site/autoload; \
  ln -sf "$PWD/plug.vim" ~/.local/share/nvim/site/autoload/plug.vim' \
  atpull'%atclone'
zplugin light junegunn/vim-plug

# fpp
zplugin ice as'program' pick'./fpp'
zplugin light facebook/PathPicker

# fzy
zplugin ice wait"1" lucid as"program" make"!PREFIX=$ZPFX install" pick"$ZPFX/bin/fzy*" \
  atclone"cp contrib/fzy-* $ZPFX/bin/" \
  atpull'%atclone'
zplugin light jhawthorn/fzy

# tmux + oh-my-tmux (gh-254 branch) + tmux plugin manager
zplugin ice lucid as"program" make"install" pick"$ZPFX/bin/tmux" \
  atclone"sh autogen.sh; ./configure --prefix=$ZPFX" \
  atpull'%atclone'
zplugin light tmux/tmux

zplugin ice lucid id-as"gpakosz/tmux" ver"gh-254" cp".tmux.conf -> $HOME/" nocompile
zplugin light gpakosz/.tmux

zplugin ice lucid nocompile
zplugin light tmux-plugins/tpm

# docker-compose
zplugin ice from"gh-r" as"program" mv"docker* -> docker-compose"
zplugin light docker/compose

# git diff
zplugin ice as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy

