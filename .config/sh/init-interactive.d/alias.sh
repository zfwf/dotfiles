# alias
alias npx='npm_config_yes=true npx'

case `uname` in
  Darwin)
    ;;
  Linux)
    alias trash=gvfs-trash
    ;;
esac

# git aliases
alias gst='git status'
alias gco='git checkout'
alias ga='git add'
alias gl='git pull'
alias gp='git push'
alias grb='git rebase'
alias gc='git commit -v'
alias gcn!='git commit -v --no-edit --amend'
alias gcam='git commit -avm'
alias gcan!='git commit -v -a --no-edit --amend'
alias gsta='git stash'
alias gchp='git cherry-pick'
alias gpf='git push --force-with-lease'
