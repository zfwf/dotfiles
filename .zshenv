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

export PATH="$PATH:$ZINIT_VAR[HOME_DIR]/polaris/bin"
