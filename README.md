# Dotfiles

A set of artifacts for system customization

## Prerequisites

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

### Windows

```pwsh
[System.Text.Encoding]::GetEncoding("utf-8").GetString($(Invoke-WebRequest -Uri "https://raw.githubusercontent.com/zfwf/dotfiles/refs/heads/main/install/init.ps1").RawContentStream.ToArray()) | Invoke-Expression
```

#### Git Bash in Windows Terminal

Paste below in Windows Terminal settings.json > profiles > list

```json
            {
                "commandline": "%USERPROFILE%\\scoop\\apps\\git\\current\\bin\\bash.exe --login -i",
                "guid": "{ec8fd78a-8825-4fb0-a81b-2f8596b94d90}",
                "icon": "%USERPROFILE%\\scoop\\apps\\git\\current\\mingw64\\share\\git\\git-for-windows.ico",
                "name": "Git Bash",
                "startingDirectory": "%USERPROFILE%"
            }
```



### POSIX

```sh
eval "$(curl https://raw.githubusercontent.com/zfwf/dotfiles/refs/heads/main/install/init.sh)"
```

# Usage

Within the home folder (i.e. `$HOME`) the `git` command is mapped to work with the bare repo (alias will work). The `~/.gitignore` ignores all immediate directories under `$HOME` to avoid seeing all the files you don't care about. To track a file in git, use `git add -f`.
