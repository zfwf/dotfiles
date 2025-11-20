#!/bin/sh

# NB Below should be idempotent

export PATH="/usr/bin:/bin:$PATH"

# x-cmd
eval "$(curl https://get.x-cmd.com)"

# install os specific pkg managers
case `uname` in
    Darwin)
        if [ ! -f $HOME/.gitconfig ]; then
            # symlinks
            ln -sf $HOME/.gitconfig_mac $HOME/.gitconfig
        fi

        # brew
        ln -sf $HOME/Brewfile_mac $HOME/Brewfile
        x brew bundle

        ;;
    Linux)
        if [ ! -f $HOME/.gitconfig ]; then
            # create symlinks
            if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
                # WSL2
                ln -sf $HOME/.gitconfig_wsl $HOME/.gitconfig
            else
                # native linux
                ln -sf $HOME/.gitconfig_linux $HOME/.gitconfig
            fi

            eval "OS_$(cat /etc/*-release | grep "^ID=")"
            case "$OS_ID" in
                "clear-linux-os")
                x swupd bundle-add devpkg-bzip2 devpkg-openssl devpkg-readline devpkg-sqlite-autoconf devpkg-libffi x11-tools package-utils
                ;;
                "manjaro")
                # xclip for clipboard support
                x pacman -S base-devel xclip
                ;;
                "ubuntu")
                ;& # fall through
                "debian")
                x apt install libssl-dev build-essential pkg-config unzip
                # git credential management
                x apt install pass gpg
                ;;
            esac

            # show desktop icons in gnome
            if [[ $(command -v gsettings) ]] ; then
                gsettings set org.gnome.desktop.background show-desktop-icons true
            fi
        fi

        # brew
        ln -sf $HOME/Brewfile_linux $HOME/Brewfile
        x brew bundle

        ;;
    MSYS* | MINGW*)
        # Git for Windows/Cygwin
        if [ ! -f $HOME/.gitconfig ]; then
            # create symlinks
            ln -sf $HOME/.gitconfig_win $HOME/.gitconfig
        fi
        ;;
esac

# setup dotfiles
eval "$(curl https://raw.githubusercontent.com/zfwf/dotfiles/refs/heads/main/install/setup-dotfiles.sh)"
