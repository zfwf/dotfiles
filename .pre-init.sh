# source from $HOME/.zshenv for zsh and $HOME/.profile for bash

installBrew() {
  if [[ $(command -v brew) == "" && ! -d /opt/homebrew ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew bundle --no-lock
  fi
}

if [ ! -f $HOME/.sh-init ]; then
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

# echo "path: $PATH"

vfox_dir="$HOME/.version-fox"
case `uname` in
  Darwin)
    ;&  # fall-through
  Linux)
    if [ ! -d "$vfox_dir" ]; then
      # get the latest version of vfox from github releases, without using jq
      tag_name=$(curl -s https://api.github.com/repos/version-fox/vfox/releases/latest | grep -o '"tag_name": "[^"]*' | grep -o '[^"]*$')
      # remove the leading 'v' if it exists
      vfox_version=${tag_name#v}
      vfox_installer="$HOME/vfox.zip"
      # download the vfox binary
      curl -L "https://github.com/version-fox/vfox/releases/download/v${vfox_version}/vfox_${vfox_version}_windows_x86_64.zip" -o "$vfox_installer"
      # extract the vfox binary
      unzip -o "$vfox_installer" -d "$vfox_dir"
      # remove the installer
      rm "$vfox_installer"
    fi

    # add vfox to path
    export PATH="$vfox_dir/$(ls -d $vfox_dir/*/ | grep -v '/$' | head -n 1):$PATH"

    # sccache
    if [[ $(command -v sccache) != "" ]]; then
      export RUSTC_WRAPPER="$(command -v sccache)"
    fi

    ;;

  MSYS* | MINGW*)
    # Git for Windows/Cygwin
    ;;
esac
