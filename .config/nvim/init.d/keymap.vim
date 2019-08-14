" general keymap
xnoremap p              pgvy|                 " copy back to buf after paste
nnoremap <C-L>          :bnext<CR>|           " next buffer
nnoremap <C-H>          :bprevious<CR>|       " previous buffer
nnoremap <Tab><Tab>     <C-^>|                " last buffer
nnoremap <Tab>          :bn<CR>|              " next buffer
nnoremap <S-Tab>        :bp<CR>|              " prev buffer

:command! BufOnly %bd|e#|bd#|       " only the buffer being edited
:command! BufR    :bufdo e!|        " Reload all

