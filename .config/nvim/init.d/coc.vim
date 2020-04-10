" coc configs

let b:coc_languages = [
  \ 'coc-rls',
  \ 'coc-java',
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-yaml',
  \ 'coc-python',
  \ 'coc-metals' 
  \]


let b:coc_extensions = [
  \ 'coc-highlight',
  \ 'coc-emmet',
  \ 'coc-snippets',
  \ 'coc-lists',
  \ 'coc-git',
  \ 'coc-tabnine',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \]

let b:coc_sources = [
  \ 'coc-tag',
  \ 'coc-word',
  \ 'coc-emoji',
  \ 'coc-omni',
  \ 'coc-syntax',
  \]

let g:coc_global_extensions = b:coc_languages + b:coc_extensions + b:coc_sources



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

nnoremap <silent> <C-k><C-i>  :CocAction('doHover')
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
" mru
nnoremap <silent> <leader><leader>  :<C-u>CocList mru<CR>
" files in project
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

" grep by motion
vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

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

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList -A grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

set cmdheight=2
" set completeopt=noinsert,noselect,menuone
set signcolumn=yes

let g:coc_auto_open = 0 " do not open quickfix automatically

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

function! s:isPreviewWindowOpen()
  for nr in range(1, winnr('$'))
    if getwinvar(nr, "&pvw") == 1
      return 1
    endif
  endfor
  return 0
endfunction

" Close preview window without changing the sizes of other windows.
function! s:closePreview()
  if !s:isPreviewWindowOpen()
    return
  endif

  let eq = &equalalways
  set noequalalways
  pclose
  if eq
    let cmd = winrestcmd()
    let &equalalways = eq
    exe cmd
  endif
endfunction

nnoremap <silent> <C-W>z :call <SID>closePreview()<cr>


" coc-settings.json uses jsonc, which adds comment syntax
autocmd FileType json syntax match Comment +\/\/.\+$+"
