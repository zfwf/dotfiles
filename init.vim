" init.vim file, Chris Chou, chhschou@gmail.com
let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')

" leader key
let mapleader="\<SPACE>"

" speed up diagnostics/gitgutter
set updatetime=100 " 100ms

" vim-plug (plugin only available after plug#end)
call plug#begin('~/.config/nvim/plugged')

Plug 'takac/vim-hardtime'   " no rep

" completion, extensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

" #visual/info
Plug 'hzchirs/vim-material'

Plug 'vim-airline/vim-airline'
let g:airline_theme = 'material'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#enabled = 1          " enable tabline
let g:airline#extensions#tabline#buffer_nr_show = 1   " display buffer number

Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
" colored parentheses
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" #tools:VCS
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'

" #tools:misc
" auto save sessions
Plug 'tpope/vim-obsession'
" `gc` comments
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" auto close/surround text
Plug 'cohama/lexima.vim'
" additional text obj
Plug 'wellle/targets.vim'
call plug#end()

" enable truecolor support
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum
set termguicolors

" enable colorscheme (cannot be place w plug)
syntax enable
filetype indent plugin on
set background=dark
colorscheme vim-material


" show whitespace characters
set list
set listchars=tab:>\ ,trail:~,extends:>,precedes:<
" highlight trailing whitespace and spaces before a tab
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\| \+\ze\t/

" set cursor
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor-blinkwait1-blinkon15-blinkoff10,r-cr:hor20-Cursor/rCursor
set mouse=a
set inccommand=nosplit
set showcmd                           " show cmd used (bottom right)
set number relativenumber             " hybrid line number
set ls=2                              " always show status line
set tabstop=2 shiftwidth=2 expandtab
set ruler
set incsearch                         " Start search before finish typing
set ignorecase                        " Make searching case insensitive
set smartcase                         " ... unless the query has capital letters.
set gdefault                          " Use 'g' flag by default with :s/foo/bar/.
set magic                             " Use 'magic' patterns (extended regular expressions).
set clipboard+=unnamedplus            " default to system clipboard
set hidden
set complete=.,w,b,u,t,i,kspell		    " `:set spell` to get completion from dictionary
set noshowmode                        " no show --Insert--, replaced by airline
set cot+=preview                      " floating preview window

" tree style file explorer
let g:netrw_liststyle=3

" general keymap
xnoremap p              pgvy|                 " copy back to buf after paste
nnoremap <C-L>          :bnext<CR>|           " next buffer
nnoremap <C-H>          :bprevious<CR>|       " previous buffer
nnoremap <Tab><Tab>     <C-^>|                " last buffer
nnoremap <Tab>          :bn<CR>|              " next buffer
nnoremap <S-Tab>        :bp<CR>|              " prev buffer

:command! BufOnly %bd|e#|bd#|       " only the buffer being edited
:command! BufR    :bufdo e!|        " Reload all


" folds
set foldmethod=syntax                 " fold by syntax, otherwise indent or manual (default)
set foldlevelstart=3                  " open fold up some
set foldcolumn=2                      " show fold indicator in gutter

" auto reload file if modified by ext program
set autoread
au FocusGained * :checktime


" auto save view (code folds etc.) and load
set viewoptions=cursor,folds,slash,unix
augroup handle_view
  autocmd!
  autocmd BufWinLeave *.* mkview!
  autocmd BufWinEnter *.* silent! loadview
augroup END

