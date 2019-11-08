# neovim + vim-plug
zplugin ice wait lucid from"gh-r" as"program" bpick"*appimage*" mv"nvim* -> nvim" pick"nvim"
zplugin light neovim/neovim

zplugin ice wait lucid \
  atclone'mkdir -p $HOME/.local/share/nvim/site/autoload; \
  ln -sf "$PWD/plug.vim" $HOME/.local/share/nvim/site/autoload/plug.vim' \
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
# zplugin ice lucid as"program" make"install" pick"$ZPFX/bin/tmux" \
#   atclone"sh autogen.sh; ./configure --prefix=$ZPFX" \
#   atpull'%atclone'
# zplugin light tmux/tmux

zplugin ice lucid id-as"gpakosz/tmux" ver"gh-254" cp".tmux.conf -> $HOME/" nocompile
zplugin light gpakosz/.tmux

zplugin ice lucid nocompile
zplugin light tmux-plugins/tpm

# docker
zplugin ice lucid id-as'docker-install' as"program" \
  mv'docker-install* -> docker.tgz' \
  atclone'tar xzvf *.tgz; rm *.tgz;' \
  atpull'%atclone' \
  pick'docker/containerd' sbin'docker/dockerd' sbin'docker/docker'
zplugin snippet "https://download.docker.com/linux/static/stable/x86_64/docker-19.03.4.tgz"

# # dockerd-rootless.sh --experimental
# zplugin ice lucid wait'1' id-as'dockerd-rootless' as"program" \
#   mv'dockerd-rootless* -> dockerd-rootless.tgz' \
#   atclone'tar xzvf *.tgz; rm *.tgz;' \
#   atpull'%atclone' \
#   sbin'docker-rootless-extras/rootlesskit' sbin'docker-rootless-extras/vpnkit' \
#   atload'docker-rootless-extras/dockerd-rootless.sh --experimental'
# zplugin snippet "https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-19.03.4.tgz"

zplugin ice from"gh-r" as"program" mv"docker* -> docker-compose"
zplugin light docker/compose

# git diff
zplugin ice as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy

