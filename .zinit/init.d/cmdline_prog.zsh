# git diff
zinit ice lucid wait'1' as"null" sbin"bin/diff-so-fancy; bin/git-dsf;"
zinit light zdharma/zsh-diff-so-fancy

# direnv
zinit ice lucid from"gh-r" as"program" mv"direnv* -> direnv" \
  atclone'./direnv hook zsh > zhook.zsh' \
  pick"direnv" src="zhook.zsh" \
  atpull'%atclone' \
  atload'export DIRENV_LOG_FORMAT=""'
zinit light direnv/direnv

# file navigation -------------
# rg + fzf
zinit ice lucid wait'1' from"gh-r" as"null" for \
  sbin"fzf" junegunn/fzf-bin 

# nnn
zinit pick"misc/quitcd/quitcd.zsh" sbin'**/nnn' make light-mode for jarun/nnn

# tmux + oh-my-tmux + tmux plugin manager
zinit ice lucid wait'1' ver'3.1b' make as"null" sbin"tmux" \
  atclone'./autogen.sh; ./configure' \
  atpull'%atclone'
zinit light tmux/tmux

zinit ice lucid wait'1' id-as'gpakosz/tmux' nocompile \
  atclone'ln -sf $PWD/.tmux.conf $HOME/.tmux.conf' \
  atpull'%atclone'
zinit light gpakosz/.tmux

zinit ice lucid wait'1' wait nocompile \
  atclone'mkdir -p ~/.tmux/plugins; ln -sf $PWD/ $HOME/.tmux/plugins/tpm' \
  atpull'%atclone'
zinit light tmux-plugins/tpm
# -----------------------------


# neovim + vim-plug ---------
zinit ice lucid wait'1' from"gh-r" as"null" sbin"nvim*/bin/nvim"
zinit light neovim/neovim

zinit ice lucid wait'1' \
  atclone'mkdir -p ~/.local/share/nvim/site/autoload; \
  ln -sf "$PWD/plug.vim" ~/.local/share/nvim/site/autoload/plug.vim' \
  atpull'%atclone'
zinit light junegunn/vim-plug
# -----------------------------

# github cli
zinit ice lucid wait'1' from"gh-r" as'null' sbin'**/gh'
zinit light cli/cli

# httpie
zinit ice lucid wait'1' \
  atclone'python3 -m pip install --user -r requirements-dev.txt; python3 -m pip install --user -e .' \
  atpull'%atclone' \
  as"null" sbin'~/Library/Python/**/bin/http -> http'
zinit light jakubroztocil/httpie

zinit ice lucid wait'1' from'gh-r' as"null" sbin'exercism'
zinit light exercism/cli


# https://hawkins.gitbook.io/consoleme/quick-start/local-development
#zinit ice lucid wait'1'
#zinit light netflix/consoleme

case `uname` in
  Darwin)
    # kubectl
    zinit ice lucid wait'1' as"null" id-as'kubectl' sbin"kubectl" \
      atclone'chmod +x ./kubectl; ./kubectl completion zsh > zsh_completion' src'zsh_completion' \
      atpull'%atclone'
    zinit snippet 'https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/darwin/amd64/kubectl'

    # minikube
    zinit ice lucid wait'1' as"null" id-as'minikube' sbin'minikube' \
      atclone'chmod +x ./minikube; ./minikube completion zsh > zsh_completion' src'zsh_completion' \
      atpull'%atclone'
    zinit snippet 'https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64'

    # aws-vault
    zinit ice lucid wait'1' from'gh-r' as"null" sbin'aws-vault* -> aws-vault'
    zinit light 99designs/aws-vault

    # aws cli
    zinit ice lucid wait'1' \
      atclone'python3 -m pip install --user -r requirements.txt; python3 -m pip install --user -e .' \
      src'bin/aws_zsh_completer.sh' \
      atpull'%atclone' \
      as"null" sbin'~/Library/Python/**/bin/aws -> aws'
    zinit light aws/aws-cli

    ;;
  Linux)
    # docker
    zinit ice lucid wait'1' id-as'docker-install' \
      mv'docker-install* -> docker.tgz' \
      atclone'tar xzvf *.tgz; rm *.tgz;' \
      atpull'%atclone' \
      as'null' sbin'docker/containerd; docker/dockerd; docker/docker'
    zinit snippet "https://download.docker.com/linux/static/stable/x86_64/docker-19.03.9.tgz"

    # rootless dockerd: run `dockerd-rootless --experimental --storage-driver vfs`
    # other prerequisites: https://docs.docker.com/engine/security/rootless/
    zinit ice lucid wait'1' id-as'dockerd-rootless' as"program" \
      mv'dockerd-rootless* -> dockerd-rootless.tgz' \
      atclone'tar xzvf *.tgz; rm *.tgz;' \
      atpull'%atclone' as'null' \
      sbin'docker-rootless-extras/dockerd-rootless.sh -> dockerd-rootless'  \
      sbin'docker-rootless-extras/rootlesskit' \
      sbin'docker-rootless-extras/vpnkit' \
      atload'export DOCKER_HOST=unix:///run/user/1000/docker.sock'
    zinit snippet "https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-19.03.9.tgz"

    # docker-compose
    zinit ice lucid wait'1' from"gh-r" as"null" sbin"docker* -> docker-compose"
    zinit light docker/compose

    # kubectl
    zinit ice lucid wait'1' as"null" id-as'kubectl' sbin"kubectl"
    zinit snippet 'https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl'

    # minikube
    zinit ice lucid wait'1' as"null" id-as'minikube' sbin'minikube'
    zinit snippet 'https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64'

    # aws-vault
    zinit ice lucid wait'1' from'gh-r' as"null" sbin'aws-vault* -> aws-vault'
    zinit light 99designs/aws-vault

    # aws cli
    zinit ice lucid wait'1' id-as'awscli' \
      mv'awscli -> awscli.zip' \
      atclone'unzip awscli.zip && rm *.zip && ./aws/install -i . ' \
      atpull'%atclone' \
      as"null" sbin'**/aws -> aws'
    zinit snippet https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
    ;;
esac

