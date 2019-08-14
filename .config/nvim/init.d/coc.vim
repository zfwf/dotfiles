" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <silent> <C-k><C-i>  :call CocAction('doHover')
nnoremap <silent> g]          <Plug>(coc-implementation)
nnoremap <silent> gY          <Plug>(coc-type-definition)
nnoremap <silent> gd          <Plug>(coc-definition)
nnoremap <silent> <F12>       <Plug>(coc-definition)
nnoremap <silent> <F24>       <Plug>(coc-references)
nnoremap <silent> <F2>        <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup jph
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

augroup fmt
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,rust,python setl formatexpr=CocAction('formatSelected')
augroup END


" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)


" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Using CocList
" mru in project
nnoremap <silent> <C-p>             :<C-u>CocList files<CR>
" Show all diagnostics
nnoremap <silent> <leader>a         :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>e         :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>c         :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>o         :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>s         :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j         :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k         :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>p         :<C-u>CocListResume<CR>

" more coclist goodness
vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap g@ :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction

set statusline^=%{coc#status()}

