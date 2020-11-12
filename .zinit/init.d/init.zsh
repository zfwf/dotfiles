if [[ ! -d $ZINIT_VAR[HOME_DIR] ]]; then
  mkdir -p $ZINIT_VAR[HOME_DIR]
fi

# install zplugin if not present, init
if [[ ! -d $ZINIT_VAR[BIN_DIR] ]]; then
  git clone https://github.com/zdharma/zinit.git $ZINIT_VAR[BIN_DIR]
  git reset --hard fbc77d998547ca546115c0fb79a17c653ab57ea1
  . $ZINIT_VAR[BIN_DIR]/zinit.zsh
  zplugin module build
else
  . $ZINIT_VAR[BIN_DIR]/zinit.zsh
fi

module_path+=$ZINIT_VAR[BIN_DIR]/zmodules/Src
# zmodload zdharma/zplugin
