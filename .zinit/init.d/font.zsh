
_get_user_font_dir() {
  case `uname` in
    Darwin)
      echo $HOME/Library/Fonts
      ;;
    Linux)
      echo $HOME/.local/share/fonts
      ;;
  esac
}

zinit ice wait'1' lucid from'gh-r' bpick'FiraCode.zip' \
  atclone'zinit_font_dir=$(_get_user_font_dir); mkdir -p $zinit_font_dir; cp -rf $PWD $zinit_font_dir;' \
  atpull'%atclone'
zinit light ryanoasis/nerd-fonts

zinit ice wait'1' lucid from'gh-r' \
  atclone'zinit_font_dir=$(_get_user_font_dir); mkdir -p $zinit_font_dir; cp -rf $PWD $zinit_font_dir;' \
  atpull'%atclone'
zinit light cormullion/juliamono

