# common gui prog


# mac utils
# copy dmg content to current directory
_extract_dmg() {
  local dmg_name="*.dmg"
  local content="/Volumes/**/*.app"
  local dmg_volume=$1

  local attached_vol=$(eval "hdiutil attach $(realpath -m $dmg_name)" | tail -n1 | cut -f 3)
  eval "cp -r $(realpath -m $content) ."
  echo "att vol $(realpath -m $attached_vol)"
  eval "hdiutil detach \"$attached_vol\""
}

# create alias for spotlight to find apps
_remove_alias_in_user_applications() {
  local app_path=$(realpath -m $1)
  local app_name=${$(basename $app_path)%.*}
  local user_applications_path=$(realpath -m ~/Applications)

  eval "rm -f '$user_applications_path/$app_name'*"; # remove old alias
}


# create alias for spotlight to find apps
_create_alias_in_user_applications() {
  local app_path=$(realpath -m $1)
  local app_name=${$(basename $app_path)%.*}
  local user_applications_path=$(realpath -m ~/Applications)
  local script="tell application \"Finder\" to make alias file to \
    POSIX file \"$app_path\" at \
    POSIX file \"$user_applications_path\""

  osascript -e "$script"
}

_install_dotapp() {
  remove_alias_in_user_applications *.app
  create_alias_in_user_applications *.app
}

# gnome utils
_create_and_link_desktop_file() {
  local app_dir=$HOME/.local/share/applications
  echo "[Desktop Entry]\nName=$4\nExec=$2 %U\nIcon=$3\nType=Application\nStartupNotify=false" > $1.desktop
  mkdir -p $app_dir
  ln -sf "$(readlink -f $1.desktop)" $app_dir/$1.desktop
}


_integrate_sys() {
  case `uname` in
    Darwin)
      _install_dotapp
      ;;
    Linux)
      _create_and_link_desktop_file $1 $2 $3 $4
      ;;
  esac

}




# ff dev edition
zinit pack"bgn" atclone+'_integrate_sys' for firefox-dev

