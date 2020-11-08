# Getting started

## Prerequisites
### Manjaro Linux
``` sh
sudo pacman -S base-devel

# install zsh
pamac install zsh jq xclip

# required by asdf-java
pamac install jq

# clipboard support
pamac install xclip

```

### Clear Linux
``` sh
# install zsh, devpkg-ncurses required to build zplugin module
sudo swupd bundle-add zsh devpkg-ncurses

# required by asdf-java
sudo swupd bundle-add jq

# required by asdf-python
sudo swupd bundle-add devpkg-bzip2 devpkg-openssl devpkg-readline devpkg-sqlite-autoconf devpkg-libffi

# required for installing rpm packages
sudo swupd bundle-add package-utils

# clipboard support
sudo swupd bundle-add x11-tools

```

### MacOS (scipt will install HomeBrew and initialize from ~/Brewfile)


## Install
``` sh
# clone to ~/.cfg as bare repo
git clone --bare https://github.com/chhschou/dotfiles ~/.cfg

# checkout `master` branch
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout main

# start zsh (wait for initialization to complete...)
zsh

# set zsh as login shell (optional)
command -v zsh | sudo tee -a /usr/share/defaults/etc/shells; sudo chsh -s $(command -v zsh) $USER

```

# Usage

Within the home folder (i.e. `$HOME`) the `git` command is mapped to work with the bare repo (alias will work). The `~/.gitignore` ignores all immediate directories under `$HOME` to avoid seeing all the files you don't care about. To track a file in git, use `git add -f`.
