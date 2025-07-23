# source from $HOME/.zshenv for zsh and $HOME/.profile for bash

installBrew() {
  if [[ $(command -v brew) == "" && ! -d /opt/homebrew ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

if [ ! -f $HOME/.sh-init ]; then
  export PATH="/usr/bin:/bin:$PATH"
  # install os specific pkg managers
  case `uname` in
    Darwin)
      if [ ! -f $HOME/.gitconfig ]; then
        # symlinks
        ln -sf $HOME/.gitconfig_mac $HOME/.gitconfig
      fi

      # brew
      ln -sf $HOME/Brewfile_mac $HOME/Brewfile
      installBrew
      brew bundle

      # add brew path
      PATH="/usr/local/bin":$PATH
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
            sudo swupd bundle-add devpkg-bzip2 devpkg-openssl devpkg-readline devpkg-sqlite-autoconf devpkg-libffi x11-tools package-utils
            ;;
          "manjaro")
            # xclip for clipboard support
            sudo pacman -S base-devel xclip
            ;;
          "ubuntu")
            ;& # fall through
          "debian")
            sudo apt install libssl-dev build-essential pkg-config unzip
            # git credential management
            sudo apt install pass gpg
            ;;
        esac

        # show desktop icons in gnome
        if [[ $(command -v gsettings) ]] ; then
          gsettings set org.gnome.desktop.background show-desktop-icons true
        fi
      fi

      # brew
      ln -sf $HOME/Brewfile_linux $HOME/Brewfile
      installBrew
      # source brew command
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 
      brew bundle

      ;;
    MSYS* | MINGW*)
      # Git for Windows/Cygwin
      if [ ! -f $HOME/.gitconfig ]; then
        # create symlinks
        ln -sf $HOME/.gitconfig_win $HOME/.gitconfig
      fi

      ;;
  esac

  # os init complete
  touch $HOME/.sh-init
fi
