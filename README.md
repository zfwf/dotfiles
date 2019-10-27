# Getting started

## Prerequisites
### Clear Linux (master branch)
``` sh
# required to build zplugin module
sudo swupd bundle-add service-os-dev

# required by asdf
sudo swupd bundle-add jq

# clipboard support
sudo swupd bundle-add x11-tools


```

### MacOS (see [mac branch](https://github.com/chhschou/dotfiles/tree/master))

### Fedora (see [fedora branch](https://github.com/chhschou/dotfiles/tree/fedora))


## Install
``` sh
# clone to ~/.cfg as bare repo
git clone --bare https://github.com/chhschou/dotfiles ~/.cfg

# checkout `master` branch (replace `master` with branch name for other branches)
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout master

# start zsh (wait for initialization to complete...)
zsh

# set zsh as login shell (optional)
chsh -s $USER $(which zsh)

```
