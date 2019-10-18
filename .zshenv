# zplugin
local -A ZPLGM
ZPLGM[HOME_DIR]=~/.zplugin
ZPLGM[BIN_DIR]=$ZPLGM[HOME_DIR]/bin
if [[ ! -d $ZPLGM[HOME_DIR] ]]; then
  mkdir -p $ZPLGM[HOME_DIR]
  git clone https://github.com/zdharma/zplugin.git $ZPLGM[BIN_DIR]
  . "$ZPLGM[BIN_DIR]/zplugin.zsh"
  zplugin module build
else
  . "$ZPLGM[BIN_DIR]/zplugin.zsh"
fi
ZPLGM[MUTE_WARNINGS]=1
module_path+=$ZPLGM[BIN_DIR]/zmodules/Src
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
  ln -sf "$(readlink -f $1.desktop)" ~/.local/share/applications/$1.desktop
}

# Order of execution of related Ice-mods: atinit -> atpull! -> make'!!' -> mv -> cp -> make! -> atclone/atpull -> make -> (plugin script loading) -> src -> multisrc -> atload.

# shim tool https://github.com/zplugin/z-a-bin-gem-node
zplugin light zplugin/z-a-bin-gem-node

# theme
zplugin ice atinit'_config_powerline'; zplugin light romkatv/powerlevel10k

# if [ $(expr $ZPLGM[INIT_STAGE] + 0) -ge 0 ]; then
#   # spack
#   zplugin ice wait lucid as'program' pick'bin/spack' \
#     atclone'./bin/spack bootstrap; \
#             ./bin/spack install lmod coreutils automake autoconf openssl \
#             libyaml readline libxslt libtool unixodbc unzip curl libevent jq \
#             tig mosh axel; \
#             _inc_and_save_init_stage; \ # move to next stage
#            ' \
#     atpull'%atclone' \
#     atload'. $PWD/share/spack/setup-env.sh'
#   zplugin light spack/spack

# fi

# asdf (no wait, need to load immediately for integration)
zplugin ice lucid ver'58eaad8ebdf506092faaf74ce31f328600f17811' as"completion" src'completions/asdf.bash' \
  atclone'. $PWD/asdf.sh; \
    asdf plugin-add nodejs; \
    asdf plugin-add python; \
    asdf plugin-add rust; \
    asdf plugin-add java; \
    asdf plugin-add scala; \
    asdf plugin-add sbt; \
    export NODEJS_CHECK_SIGNATURES=no; \
    cd $HOME; asdf install; asdf reshim; \
    asdf global nodejs $(asdf list nodejs); \
    asdf global python $(asdf list python); \
    asdf global rust $(asdf list rust); \
    asdf global java $(asdf list java); \
    asdf global scala $(asdf list scala); \
    asdf global sbt $(asdf list sbt); \
    ' \
  atpull'%atclone' \
  atload'. $PWD/asdf.sh; \
    export NODEJS_CHECK_SIGNATURES=no; \
    export JAVA_HOME=$(asdf where java);'
zplugin light asdf-vm/asdf

# vscode
zplugin ice wait lucid from"gh-r" as"program" bpick"*tar.gz" mv'codium -> code' sbin'code' pick'/dev/null'
zplugin light VSCodium/vscodium

# ff dev edition
zplugin ice as'program' pick'firefox/firefox' \
  atclone'tar jxf *.tar.bz2; _create_and_link_desktop_file firefox "$(readlink -f firefox/firefox)" firefox;' \
  atpull'%atclone'
zplugin snippet https://download-installer.cdn.mozilla.net/pub/devedition/releases/70.0b4/linux-x86_64/en-US/firefox-70.0b4.tar.bz2

# gitahead
zplugin ice wait lucid from"gh-r" as"program" bpick"*sh"  pick'./GitAhead/GitAhead' \
  atclone'./GitAhead*.sh --include-subdir;' \
  atpull'%atclone'
zplugin light gitahead/gitahead

# neovim + vim-plug
zplugin ice wait lucid from"gh-r" as"program" bpick"*appimage*" mv"nvim* -> nvim" pick"nvim"
zplugin light neovim/neovim

zplugin ice wait lucid \
  atclone'mkdir -p ~/.local/share/nvim/site/autoload; \
  ln -sf "$PWD/plug.vim" ~/.local/share/nvim/site/autoload/plug.vim' \
  atpull'%atclone'
zplugin light junegunn/vim-plug

# fpp
zplugin ice as'program' pick'./fpp'
zplugin light facebook/PathPicker

# fzy
zplugin ice wait"1" lucid as"program" make"!PREFIX=$ZPFX install" pick"$ZPFX/bin/fzy*" \
  atclone"cp contrib/fzy-* $ZPFX/bin/" \
  atpull'%atclone'
zplugin light jhawthorn/fzy

# tmux + oh-my-tmux (gh-254 branch) + tmux plugin manager
zplugin ice lucid as"program" make"install" pick"$ZPFX/bin/tmux" \
  atclone"sh autogen.sh; ./configure --prefix=$ZPFX" \
  atpull'%atclone'
zplugin light tmux/tmux

zplugin ice lucid id-as"gpakosz/tmux" ver"gh-254" cp".tmux.conf -> $HOME/" nocompile
zplugin light gpakosz/.tmux

zplugin ice lucid nocompile
zplugin light tmux-plugins/tpm

# docker-compose
zplugin ice from"gh-r" as"program" mv"docker* -> docker-compose"
zplugin light docker/compose

# font
zplugin ice from'gh-r' bpick'FiraCode.zip' \
  atclone'mkdir -p ~/.local/share/fonts; ln -sf $PWD ~/.local/share/fonts/FiraCode;' \
  atpull'%atclone'
zplugin light ryanoasis/nerd-fonts

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
