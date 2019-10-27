# asdf (no wait, need to load immediately for integration)
zplugin ice lucid ver'58eaad8ebdf506092faaf74ce31f328600f17811' as"completion" src'completions/asdf.bash' \
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
  atload'. $PWD/asdf.sh; \
    export NODEJS_CHECK_SIGNATURES=no; \
    export JAVA_HOME=$(asdf where java);'
zplugin light asdf-vm/asdf

