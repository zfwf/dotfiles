# neovim + vim-plug
zplugin ice lucid wait from"gh-r" as"program" bpick"*appimage*" mv"nvim* -> nvim" pick"nvim"
zplugin light neovim/neovim

zplugin ice lucid wait \
  atclone'mkdir -p $HOME/.local/share/nvim/site/autoload; \
  ln -sf "$PWD/plug.vim" $HOME/.local/share/nvim/site/autoload/plug.vim' \
  atpull'%atclone'
zplugin light junegunn/vim-plug

# docker
zplugin ice lucid wait id-as'docker-install' as"program" \
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

zplugin ice lucid wait from"gh-r" as"program" mv"docker* -> docker-compose"
zplugin light docker/compose


