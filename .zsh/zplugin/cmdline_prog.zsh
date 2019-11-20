# fpp
# git diff
zplugin ice lucid as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy

# fpp
zplugin ice lucid wait as'program' pick'./fpp'
zplugin light facebook/PathPicker

# fzy
zplugin ice lucid wait as"program" make"!PREFIX=$ZPFX install" pick"$ZPFX/bin/fzy*" \
  atclone"cp contrib/fzy-* $ZPFX/bin/" \
  atpull'%atclone'
zplugin light jhawthorn/fzy

# tmux + oh-my-tmux (nb use ver"gh-254" for tmux 3.0+) + tmux plugin manager
zplugin ice lucid wait as"program" make"install" pick"$ZPFX/bin/tmux" \
  atclone"sh autogen.sh; ./configure --prefix=$ZPFX" \
  atpull'%atclone'
zplugin light tmux/tmux

zplugin ice lucid wait id-as'gpakosz/tmux' ver'gh-254' nocompile \
  atclone'ln -sf $PWD/.tmux.conf $HOME/.tmux.conf' \
  atplull'%atclone'
zplugin light gpakosz/.tmux

zplugin ice lucid wait nocompile
zplugin light tmux-plugins/tpm


