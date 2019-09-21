# zplugin
local -A ZPLGM
ZPLGM[HOME_DIR]=~/.zplugin
ZPLGM[BIN_DIR]=$ZPLGM[HOME_DIR]/bin
if [[ ! -d $ZPLGM[HOME_DIR] ]]; then
  mkdir -p ZPLGM[HOME_DIR]
  git clone https://github.com/zdharma/zplugin.git $ZPLGM[BIN_DIR]
  source "$ZPLGM[BIN_DIR]/zplugin.zsh"
  zplugin self-update
  zplugin module build  # zplugin module for auto compile sourced scripts
else
  source "$ZPLGM[BIN_DIR]/zplugin.zsh"
fi
ZPLGM[MUTE_WARNINGS]=1
module_path+=("$HOME/.zplugin/bin/zmodules/Src")
zmodload zdharma/zplugin

# theme specific
_config_powerline() {
  ## if using awesome font-config
  #POWERLEVEL9K_MODE='awesome-fontconfig'
  ## if using nerd font
  POWERLEVEL9K_MODE='nerdfont-fontconfig'

  # disable auto window title
  #DISABLE_AUTO_TITLE="true"

  # Disable dir/git icons
  POWERLEVEL9K_HOME_ICON=''
  POWERLEVEL9K_HOME_SUB_ICON=''
  POWERLEVEL9K_FOLDER_ICON=''
  POWERLEVEL9K_VCS_GIT_ICON=''
  POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
  POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=''
  POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''

  POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
  POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
  POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
  POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
  POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'

  POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
  POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'

  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time)

  POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=4

  #python format: http://strftime.org/
  POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S}"

  # = 0 to always print
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1

  POWERLEVEL9K_STATUS_VERBOSE=false
}


_create_and_link_desktop_file() {
  echo "[Desktop Entry]\nName=$1\nExec=$2 %U\nIcon=$3\nType=Application\nStartupNotify=true" > $1.desktop
  ln -s "$(readlink -f $1.desktop)" ~/.local/share/applications/$1.desktop
}



# Order of execution of related Ice-mods: atinit -> atpull! -> make'!!' -> mv -> cp -> make! -> atclone/atpull -> make -> (plugin script loading) -> src -> multisrc -> atload.


  # theme
  zplugin ice atinit'_config_powerline'; zplugin light romkatv/powerlevel10k

  # spack
  zplugin ice as'program' pick'bin/spack' \
    atclone'./bin/spack install zlib automake autoconf openssl \
            libyaml readline libxslt libtool unixodbc unzip curl libevent \
            tig jq mosh axel \
           ' \
    atload'source $PWD/share/spack/setup-env.sh;'
  zplugin light spack/spack

  # asdf
  zplugin ice lucid wait \
    atclone'source $PWD/asdf.sh;
      asdf plugin-add nodejs; \
      asdf plugin-add python; \
      asdf plugin-add rust; \
      asdf plugin-add java; \
      asdf plugin-add gradle; \
      export NODEJS_CHECK_SIGNATURES=no; \
      cd $HOME; asdf install; asdf reshim; \
      ' \
    as"completion" src'completions/asdf.bash' \
    atload'export NODEJS_CHECK_SIGNATURES=no; \
      source $PWD/asdf.sh; \
      export JAVA_HOME=$(asdf where java); '
  zplugin light asdf-vm/asdf


  # ff dev edition
  # zplugin as'program' pick'firefox'
  # zplugin snippet https://download-installer.cdn.mozilla.net/pub/devedition/releases/70.0b4/linux-x86_64/en-US/firefox-70.0b4.tar.bz2

  # gitkraken
  zplugin ice atclone'mkdir gitkraken-amd64; \
    tar -C gitkraken-amd64 -xzf gitkraken*.tar.gz; \
    ln -s gitkraken-amd64/gitkraken/gitkraken; \
    _create_and_link_desktop_file GitKraken "$(readlink -f gitkraken)" gitkraken' \
    as'program' pick"gitkraken"
  zplugin snippet https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz

  # station
  zplugin ice from"gh-r" as"program" bpick"*appimage*" mv"browserX* -> station" pick"station"
  zplugin light getstation/desktop-app-releases

  # neovim + vim-plug
  zplugin ice from"gh-r" as"program" bpick"*appimage*" mv"nvim* -> nvim" pick"nvim" \
    atclone'pip install neovim'
  zplugin light neovim/neovim

  zplugin ice as'program' pick'./fpp'
  zplugin light facebook/PathPicker

  zplugin ice lucid \
    atclone'mkdir -p ~/.local/share/nvim/site/autoload; \
    ln -s "$PWD/plug.vim" ~/.local/share/nvim/site/autoload/plug.vim'
  zplugin light junegunn/vim-plug

  # fzy
  zplugin ice wait"1" lucid as"program" make"!PREFIX=$ZPFX install" \
    atclone"cp contrib/fzy-* $ZPFX/bin/" \
    pick"$ZPFX/bin/fzy*"
  zplugin light jhawthorn/fzy

  # tmux + oh-my-tmux (gh-254 branch) + tmux plugin manager
  zplugin ice lucid as"program" atclone"sh autogen.sh; ./configure --prefix=$ZPFX" \
    make"install" pick"$ZPFX/bin/tmux"
  zplugin light tmux/tmux

  zplugin ice lucid id-as"gpakosz/tmux" ver"gh-254" cp".tmux.conf -> $HOME/" nocompile
  zplugin light gpakosz/.tmux

  zplugin ice lucid nocompile
  zplugin light tmux-plugins/tpm

  # docker-compose
  zplugin ice from"gh-r" as"program" mv"docker* -> docker-compose"
  zplugin light docker/compose


  # autosuggestions
  zplugin ice wait silent atload'export ZSH_AUTOSUGGEST_USE_ASYNC=true; _zsh_autosuggest_start'
  zplugin light zsh-users/zsh-autosuggestions

  # git diff
  zplugin ice as"program" pick"bin/git-dsf"
  zplugin light zdharma/zsh-diff-so-fancy

  # OMZ lib
  zplugin ice wait lucid
  zplugin snippet OMZ::lib/git.zsh

  zplugin ice lucid atinit'ZSH_CACHE_DIR="$HOME/.zcompcache"'
  zplugin snippet OMZ::lib/history.zsh

  zplugin ice wait"1" lucid # `ls` colors
  zplugin snippet OMZ::lib/theme-and-appearance.zsh

  zplugin ice wait lucid
  zplugin snippet OMZ::lib/completion.zsh

  # OMZ plugin
  zplugin ice wait lucid atload"unalias grv g"
  zplugin snippet OMZ::plugins/git/git.plugin.zsh

  zplugin ice wait lucid as"completion"
  zplugin snippet OMZ::plugins/docker/_docker

  zplugin ice wait lucid as"completion"
  zplugin snippet OMZ::plugins/docker-compose/_docker-compose

  zplugin ice wait lucid
  zplugin snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh

  # more completions
  zplugin ice wait blockf lucid
  zplugin light zsh-users/zsh-completions

  zplugin ice wait lucid
  zplugin light zdharma/fast-syntax-highlighting

autoload -Uz compinit
compinit

zplugin cdreplay -q

# android
if [ -d "$HOME/Android/Sdk" ]; then
  export ANDROID_HOME=$HOME/Android/Sdk
  if [ -d "$ANDROID_HOME/ndk_bundle" ]; then
    export NDK_ROOT=$ANDROID_HOME/ndk_bundle
    export ANDROID_NDK_HOME=$NDK_ROOT
  fi
  PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin
fi
