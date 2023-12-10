
extract-filename() {
  echo $(basename -- $1)
}

extract-filename-wo-ext() {
  echo ${$(extract-filename $1)%.*}
}

co() {
  if [ -z "$4" ]; then
    local cloned_folder=$(extract-filename-wo-ext $2)-$1-$3
    local branch_name=$1/$3
  else
    local cloned_folder=$(extract-filename-wo-ext $2)-$4-$1-$3
    local branch_name=$4/$1/$3
  fi
  command git clone $2 $cloned_folder
  cd $cloned_folder
  if [ -f ".meta" ]; then
    meta git update
    if [ ! -z "$4" ]; then
      meta git checkout master
      meta git update
    fi
    meta git checkout -b $branch_name
    meta exec "git push -u origin $branch_name"
    meta exec 'npm ci'
  else
    command git checkout -b $branch_name
    command git push -u origin $branch_name
    npm ci
    npm run build --if-present
  fi
}

cof-beta() {
  co 'feat' "$@" 'beta'
}

cof() {
  co 'feat' "$@"
}

cob-beta() {
  co 'fix' "$@" 'beta'
}

cob() {
  co 'fix' "$@"
}

