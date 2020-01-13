# git diff
zplugin ice lucid as"null" sbin"bin/diff-so-fancy; bin/git-dsf;"
zplugin light zdharma/zsh-diff-so-fancy

# fpp
zplugin ice lucid make as'null' sbin'fpp'
zplugin light facebook/PathPicker

# rg
zplugin ice lucid from"gh-r" as'null' sbin'ripgrep*/rg'
zplugin light BurntSushi/ripgrep

# fd
zplugin ice lucid from"gh-r" as'null' sbin'fd*/fd'
zplugin light sharkdp/fd

# fzf
zplugin pack"bgn-binary" for fzf

# tmux + oh-my-tmux (nb use ver"gh-254" for tmux 3.0+) + tmux plugin manager
zplugin ice lucid make as"null" sbin"tmux" \
  atclone'./autogen.sh; ./configure' \
  atpull'%atclone'
zplugin light tmux/tmux

zplugin ice lucid wait id-as'gpakosz/tmux' nocompile \
  atclone'ln -sf $PWD/.tmux.conf $HOME/.tmux.conf' \
  atplull'%atclone'
zplugin light gpakosz/.tmux

zplugin ice lucid wait nocompile
zplugin light tmux-plugins/tpm
# -----------------------------


 # neovim + vim-plug ---------
zplugin ice lucid wait from"gh-r" as"null" sbin"nvim*/bin/nvim"
zplugin light neovim/neovim

zplugin ice lucid wait \
  atclone'mkdir -p ~/.local/share/nvim/site/autoload; \
  ln -sf "$PWD/plug.vim" ~/.local/share/nvim/site/autoload/plug.vim' \
  atpull'%atclone'
zplugin light junegunn/vim-plug
# -----------------------------



