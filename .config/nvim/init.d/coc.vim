if !exists('g:vscode')

  " coc configs
  let b:coc_languages = [
    \ 'coc-rust-analyzer',
    \ 'coc-java',
    \ 'coc-tsserver',
    \ 'coc-json',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-yaml',
    \ 'coc-pyright',
    \ 'coc-metals',
    \ 'coc-sh'
    \]


  let b:coc_extensions = [
    \ 'coc-emmet',
    \ 'coc-lists',
    \ 'coc-git',
    \ 'coc-eslint',
    \ 'coc-prettier',
    \ 'coc-stylelint',
    \ 'coc-tailwindcss',
    \ 'coc-explorer',
    \ 'coc-calc',
    \ 'coc-inline-jest',
    \ 'coc-import-cost',
    \ 'coc-deno',
    \ 'coc-marketplace'
    \]

  let g:coc_global_extensions = b:coc_languages + b:coc_extensions

  " default config from https://github.com/neoclide/coc.nvim --------
  " TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Give more space for displaying messages.
  set cmdheight=2

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
  endif

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  " Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
  nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

  " NeoVim-only mapping for visual mode scroll
  " Useful on signatureHelp after jump placeholder of snippet expansion
  if has('nvim')
    vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
    vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " grep from selected
  vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
  " nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

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
  command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

  function! s:GrepArgs(...)
    let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
          \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
    return join(list, "\n")
  endfunction

  " Keymapping for grep word under cursor with interactive mode
  " nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

  " end default config------------------------

  " Mappings for CoCList
  " grep in project
  nnoremap <silent><nowait> <leader><leader>    :<C-u>CocList grep<CR>
  " files in project
  nnoremap <silent><nowait> <C-p>               :<C-u>CocList files<CR>
  " explorer
  nnoremap <silent><nowait> <leader>f           :<C-u>CocCommand explorer<CR>
  " buffers
  nnoremap <silent><nowait> <leader>b           :<C-u>CocList buffers<CR>
  " Show all errors.
  nnoremap <silent><nowait> <leader>d           :<C-u>CocList diagnostics<CR>
  " Do default action for next item.
  nnoremap <silent><nowait> <leader>j           :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <leader>k           :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <leader>p           :<C-u>CocListResume<CR>

  " re-Keymapping for grep word under cursor
  nnoremap <silent> <Leader>g :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>


  " let g:coc_auto_open = 0 " do not open quickfix automatically
  " coc-settings.json uses jsonc, which adds comment syntax
  autocmd FileType json syntax match Comment +\/\/.\+$+


endif
