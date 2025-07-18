pport() {
  lsof -t -i tcp:$1
}

sigterm() {
  kill -15 $(pport $1)
}


get_path_stripper() {
  local stripper="s/$(echo $1 | sed 's/\//\\\//g')//g"

  echo $stripper
}

strip_then_prepend() {
  local stripped=$(echo $1 | sed $2)

  echo "$3:$stripped"
}

strip_then_append() {
  local stripped=$(echo $1 | sed $2)

  echo "$stripped:$3"
}


