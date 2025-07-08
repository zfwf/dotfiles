" general keymap
if !exists('g:vscode')
  nnoremap <Tab><Tab>     <C-^>|          " last buffer
  nnoremap <Tab>          :bn<CR>|        " next buffer
  nnoremap <S-Tab>        :bp<CR>|        " prev buffer

  :command! BufOnly %bd|e#|bd#|           " only the buffer being edited
  :command! BufR    :bufdo e!|            " Reload all

  nnoremap <leader>bb :BufOnly<CR>|
  nnoremap <leader>br :BufR<CR>|
  nnoremap <leader>bd :bd<CR>|

endif

inoremap jk             <esc>|            " map jk to escape
xnoremap p              pgvy|             " copy back to buf after paste
