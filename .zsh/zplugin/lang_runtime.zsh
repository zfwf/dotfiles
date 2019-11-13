# asdf (no wait, need to load immediately for integration)
zplugin ice lucid depth'1' \
  atclone'. $PWD/asdf.sh; \
    asdf plugin-add nodejs; \
    asdf plugin-add python; \
    asdf plugin-add rust; \
    asdf plugin-add java; \
    asdf plugin-add scala; \
    asdf plugin-add sbt; \
    export NODEJS_CHECK_SIGNATURES=no; \
    cd $HOME; asdf install; asdf reshim; \
    asdf global nodejs $(asdf list nodejs); \
    asdf global python $(asdf list python); \
    asdf global rust $(asdf list rust); \
    asdf global java $(asdf list java); \
    asdf global scala $(asdf list scala); \
    asdf global sbt $(asdf list sbt); \
    ' \
  atpull'%atclone' \
  src'completions/asdf.bash' \
  atload'. $PWD/asdf.sh; \
    export NODEJS_CHECK_SIGNATURES=no; \
    . $HOME/.asdf/plugins/java/set-java-home.sh;'
zplugin light asdf-vm/asdf

