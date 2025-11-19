# Getting started

## Prerequisites

Zsh might report `ERROR: this script is obsolete, please see git-completion.zsh` please see https://stackoverflow.com/a/69396005

#### WSL2

```
# set wsl default version
wsl --set-default-version 2

# check wsl distro versions
wsl --list --verbose

# convert to wsl version 2
wsl --set-version <distro name> 2

# essentials
wsl sudo apt-get install build-essential curl git zsh pkg-config libssl-dev libncurses-dev

# install fonts (from inside font folder)
.\FontReg.exe /copy


```

## Install

```sh
# install x-cmd
eval "$(curl https://get.x-cmd.com)"
x install git # install git if required

# clone to ~/.cfg as bare repo
git clone --bare https://github.com/zfwf/dotfiles ~/.cfg

# checkout `master` branch
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout main

# start zsh (wait for initialization to complete...)
zsh

# set zsh as login shell (optional)
command -v zsh | sudo tee -a /usr/share/defaults/etc/shells; sudo chsh -s $(command -v zsh) $USER

```

# Usage

Within the home folder (i.e. `$HOME`) the `git` command is mapped to work with the bare repo (alias will work). The `~/.gitignore` ignores all immediate directories under `$HOME` to avoid seeing all the files you don't care about. To track a file in git, use `git add -f`.
