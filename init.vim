" init.vim file, Chris Chou, chhschou@gmail.com
let g:python2_host_prog = $HOME . '/.brew/bin/python'
let g:python3_host_prog = $HOME . '/.brew/bin/python3'

" vim-plug (plugin only available after plug#end)
call plug#begin('~/.config/nvim/plugged')

" syntax
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'elzr/vim-json'
Plug 'rust-lang/rust.vim'
Plug 'jvirtanen/vim-octave'
Plug 'hdima/python-syntax'
Plug 'plasticboy/vim-markdown'
Plug 'octol/vim-cpp-enhanced-highlight'

" visual/info
Plug 'vim-airline/vim-airline'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'luochen1990/rainbow'

" tools
Plug 'sgur/vim-editorconfig'
Plug 'sbdchd/neoformat'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-obsession'
Plug 'ludovicchabant/vim-gutentags'
au FileType gitcommit,gitrebase let g:gutentags_enabled=0
Plug 'jreybert/vimagit'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'cohama/lexima.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-vdebug/vdebug'
Plug 'wellle/targets.vim'
Plug 'leafgarland/typescript-vim'
Plug '~/.brew/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" enable truecolor support
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum
set termguicolors
" enable color scheme
syntax enable
filetype indent plugin on
set background=dark
colorscheme PaperColor

" rainbow parentheses
let g:rainbow_active = 1

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

" leader key
let mapleader="\<SPACE>"

" speed up gitgutter
set updatetime=100 " 100ms



" langclient
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['npx', '-p', 'javascript-typescript-langserver', 'javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['pyls'],
    \ }
" Or map each action separately
nnoremap <silent> <C-k><C-i> : LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F12> :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F24> :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('smart_case', v:true) " smart_case for match with capitals
" enable tab completion
inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" : "\<Tab>"


" tree style file explorer
let g:netrw_liststyle=3

" vim-airline configs
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#enabled = 1          " enable tabline
let g:airline#extensions#tabline#buffer_nr_show = 1   " display buffer number


" general keymap
xnoremap p              pgvy|                 " copy back to buf after paste
nnoremap <C-L>          :bnext<CR>|           " next buffer
nnoremap <C-H>          :bprevious<CR>|       " previous buffer
nnoremap <Tab><Tab>     :b#<CR>|              " last buffer
nnoremap <Tab>          :bn<CR>|              " next buffer
nnoremap <S-Tab>        :bp<CR>|              " prev buffer

:command! BufOnly %bd|e#|bd#|       " only the buffer being edited
:command! BufR    :bufdo e!|        " Reload all

" fzf
" use ripgrep instead of ag:
let s:rgIgnoreGlobs='!{.git,node_modules,vendors}/'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -g "' . s:rgIgnoreGlobs . '" ' .shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
"
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" search for files in project
nnoremap <silent> <Leader><Leader> :Files $PWD<CR>
" search word under cursor in tags
nnoremap <silent> g] :Tags <C-R><C-W><CR>
" search word under cursor in project
nnoremap <silent> g/ :Rg <C-R><C-W><CR>

" folds
set foldmethod=syntax                 " fold by syntax, otherwise indent or manual (default)
set foldlevelstart=3                  " open fold up some
set foldcolumn=2                      " show fold indicator in gutter

" auto save view (code folds etc.) and load
set viewoptions=cursor,folds,slash,unix
augroup handle_view
  autocmd!
  autocmd BufWinLeave *.* mkview!
  autocmd BufWinEnter *.* silent! loadview
augroup END

" neoformat
let g:neoformat_only_msg_on_error = 1
nnoremap =              :Neoformat<CR>
augroup fmt
  autocmd!
  autocmd BufWritePre *.* undojoin | Neoformat
augroup END
