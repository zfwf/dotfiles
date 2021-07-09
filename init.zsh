if ( type orbiter > /dev/null ); then
  # create script in ${HOME}/.cache
  eval "$(orbiter)" > /dev/null 2>&1

  local orbiter_dashboard_bin_path="$HOME/.orbiter/dashboard/bin"
  local stripper=$(get_path_stripper $orbiter_dashboard_bin_path)

  export PATH=$(strip_then_prepend "$PATH" \
    "$stripper" \
    "$orbiter_dashboard_bin_path")
fi

