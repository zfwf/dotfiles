if !exists('g:vscode')
  " auto save view (code folds etc.) and load
  set viewoptions=cursor,folds,slash,unix
  augroup handle_view
    autocmd!
    autocmd BufWinLeave *.* mkview!
    autocmd BufWinEnter *.* silent! loadview
  augroup END

endif
