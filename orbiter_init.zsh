# orbiter
if ( type orbiter > /dev/null ); then
  # create script in ${HOME}/.cache
  eval "$(orbiter)" > /dev/null 2>&1

  local orbiter_bin_path="$ORBITER_CONST[BIN_DIR]"
  local orbiter_dashboard_bin_path="$ORBITER_CONST[DASHBOARD_BIN_DIR]"
  local stripper=$(get_path_stripper $orbiter_dashboard_bin_path)

  export PATH=$(strip_then_prepend "$PATH" \
    "$(get_path_stripper $orbiter_dashboard_bin_path)" \
    "$orbiter_dashboard_bin_path")
  export PATH=$(strip_then_prepend "$PATH" \
    "$(get_path_stripper $orbiter_bin_path)" \
    "$orbiter_bin_path")

fi



