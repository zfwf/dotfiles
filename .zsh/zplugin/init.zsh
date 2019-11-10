# install zplugin if not present, init
if [[ ! -d $ZPLGM[HOME_DIR] ]]; then
  mkdir -p $ZPLGM[HOME_DIR]
  git clone https://github.com/zdharma/zplugin.git $ZPLGM[BIN_DIR]
  . $ZPLGM[BIN_DIR]/zplugin.zsh
  zplugin module build
else
  . $ZPLGM[BIN_DIR]/zplugin.zsh
fi
ZPLGM[MUTE_WARNINGS]=1
module_path+=$ZPLGM[BIN_DIR]/zmodules/Src
zmodload zdharma/zplugin

