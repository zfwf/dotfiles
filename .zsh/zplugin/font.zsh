
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
  atclone'zinit_font_dir=$(_get_user_font_dir); mkdir -p $zinit_font_dir; ln -sf $PWD $zinit_font_dir/FiraCode;' \
  atpull'%atclone'
zinit light ryanoasis/nerd-fonts
