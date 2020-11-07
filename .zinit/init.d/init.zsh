if [[ ! -d $ZINIT_VAR[HOME_DIR] ]]; then
  mkdir -p $ZINIT_VAR[HOME_DIR]
fi

# install zplugin if not present, init
if [[ ! -d $ZINIT_VAR[BIN_DIR] ]]; then
  git clone https://github.com/zdharma/zinit.git $ZINIT_VAR[BIN_DIR]
  . $ZINIT_VAR[BIN_DIR]/zinit.zsh
  zplugin module build
else
  . $ZINIT_VAR[BIN_DIR]/zinit.zsh
fi

module_path+=$ZINIT_VAR[BIN_DIR]/zmodules/Src
# zmodload zdharma/zplugin

