if !exists('g:vscode')
  " activate anyfold by default
  augroup anyfold
      autocmd!
      autocmd Filetype * AnyFoldActivate
  augroup END

  " disable anyfold for large files
  let g:LargeFile = 1000000 " file is large if size greater than 1MB
  autocmd BufReadPre,BufRead * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
  function LargeFile()
      augroup anyfold
          autocmd! " remove AnyFoldActivate
          autocmd Filetype * setlocal foldmethod=indent " fall back to indent folding
      augroup END
  endfunction
  set foldlevel=3
  " traditional fold
  " set foldmethod=syntax                 " fold by syntax, otherwise indent or manual (default)
  " set foldlevelstart=3                  " open fold up some
  " set foldcolumn=2                     " show fold indicator in gutter
endif
