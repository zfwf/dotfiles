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

# zplugin
local -A ZPLGM
ZPLGM[HOME_DIR]=~/.zplugin
ZPLGM[BIN_DIR]=$ZPLGM[HOME_DIR]/bin
if [[ ! -d $ZPLGM[HOME_DIR] ]]; then
  mkdir -p ZPLGM[HOME_DIR]
  git clone https://github.com/zdharma/zplugin.git $ZPLGM[BIN_DIR]
  source "$ZPLGM[BIN_DIR]/zplugin.zsh"
  zplugin self-update
else
  source "$ZPLGM[BIN_DIR]/zplugin.zsh"
fi
ZPLGM[MUTE_WARNINGS]=1

# Order of execution of related Ice-mods: atinit -> atpull! -> make'!!' -> mv -> cp -> make! -> atclone/atpull -> make -> (plugin script loading) -> src -> multisrc -> atload.
  # theme
  zplugin ice atinit"_config_powerline"; zplugin light romkatv/powerlevel10k

  # programs

  # gitkraken
  zplugin ice as"program" atclone"mkdir gitkraken-amd64; tar -C gitkraken-amd64 -xzf gitkraken*.tar.gzt; ln -s gitkraken-amd64/gitkraken/gitkraken" pick"gitkraken"
  zplugin snippet https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz

  # station
  zplugin ice from"gh-r" as"program" bpick"*appimage*" mv"browserX* -> station" pick"station"
  zplugin light getstation/desktop-app-releases

  # neovim
  zplugin ice from"gh-r" as"program" bpick"*appimage*" mv"nvim* -> nvim" pick"nvim"
  zplugin light neovim/neovim

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


  # pyenv + pyenv-viftualenv
  zplugin ice atclone"git clone https://github.com/pyenv/pyenv-virtualenv.git ./plugins/pyenv-virtualenv; \
    ./libexec/pyenv init - > zpyenv.zsh; ./libexec/pyenv virtualenv-init - > zpyenv-virtualenv.zsh;  \
    pyenv install 3.7.4; pyenv global 3.7.4; pip install pynvim" \
    atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" \
    as'command' pick'bin/pyenv' multisrc'{zpyenv,zpyenv-virtualenv}.zsh'
  zplugin light pyenv/pyenv

  # poetry
  zplugin ice as"completion" atclone"python ./get-poetry.py; \
    $HOME/.poetry/bin/poetry completions zsh > _poetry" \
    atpull"%atclone" atload'PATH="$HOME/.poetry/bin:$PATH"'
  zplugin light sdispater/poetry

  # nvm
  zplugin ice atinit'export NVM_AUTO_USE=true'
  zplugin light lukechilds/zsh-nvm

  # cargo (via rustup)
  zplugin ice atclone"./rustup-init.sh; rustup completions zsh > _rustup" atpull"%atclone" \
    as"completion" src'_rustup' \
    atload'PATH="$HOME/.cargo/bin:$PATH"; export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"'
  zplugin light rust-lang/rustup.rs


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

  # plugins
  zplugin ice wait blockf lucid
  zplugin light zsh-users/zsh-completions

  zplugin ice wait silent atload'export ZSH_AUTOSUGGEST_USE_ASYNC=true'
  zplugin light zsh-users/zsh-autosuggestions

  zplugin ice as"program" pick"bin/git-dsf"
  zplugin light zdharma/zsh-diff-so-fancy

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

case `uname` in
  Darwin) # commands for OS X go here
    if [ -d "/Library/java" ]; then
      export JAVA_HOME=/Library/java/JavaVirtualMachines/jdk-10.0.2.jdk/Contents/Home
      export JRE_HOME=$JAVA_HOME
    fi

    # brew
    if [ -d "$HOME/.brew" ]; then
      PATH="$HOME/.brew/bin:$PATH"
      export MANPATH="$(brew --prefix)/share/man:$MANPATH"
      export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"
    fi
    ;;
  Linux) # commands for Linux go here
    # java
    if command -v java &> /dev/null; then
      export JAVA_HOME=${$(readlink -f `command -v java`)%/*/*}
      export JRE_HOME=$JAVA_HOME
    fi
    ;;
esac
