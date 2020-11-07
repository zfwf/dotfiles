# compile zsh to zwc
alias source='builtin source "$HOME/compile-source-file" source "$#" "$@"'
alias      .='builtin .      "$HOME/compile-source-file" .      "$#" "$@"'

# pre-init script
[ -f $HOME/.pre-init.sh ] && . $HOME/.pre-init.sh

# zinit
declare -A ZINIT_VAR
ZINIT_VAR[HOME_DIR]=$HOME/.zinit
ZINIT_VAR[BIN_DIR]="$ZINIT_VAR[HOME_DIR]/bin"
ZINIT_VAR[PLUGIN_SCRIPT_DIR]=$ZINIT_VAR[HOME_DIR]/init.d
. $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/init.zsh

# asdf completion
zinit ice lucid blockf
zinit light ${ASDF_DIR}/completions

# Order of execution of related Ice-mods: atinit -> atpull! -> make'!!' -> mv -> cp -> make! -> atclone/atpull -> make -> (plugin script loading) -> src -> multisrc -> atload.

# shim tool
zinit light zinit-zsh/z-a-bin-gem-node
# patch tool
zinit light zinit-zsh/z-a-patch-dl


# lang/runtimes
[ -f  $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/lang_runtime.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/lang_runtime.zsh

# common command line programs
[ -f  $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/cmdline_prog.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/cmdline_prog.zsh

# misc configs
case `uname` in
  Darwin)
    ;;
  Linux)
    ;;
esac

# theme
[ -f $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/theme.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/theme.zsh

# font
[ -f $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/font.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/font.zsh

# other paths
[ -f $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/paths.sh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/paths.sh

#  completions
[ -f $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/comp.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/comp.zsh

# common gui programs
[ -f $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/gui_prog.zsh ] && . $ZINIT_VAR[PLUGIN_SCRIPT_DIR]/gui_prog.zsh

# needs to be the last plugin
zinit ice wait lucid
zinit light zdharma/fast-syntax-highlighting

autoload -Uz compinit
compinit

zinit cdreplay -q

