" init.vim file, Chris Chou, chhschou@gmail.com

" vim-plug (plugin only available after plug#end)
call plug#begin('~/.config/nvim/plugged')
" visual/info
Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'
Plug 'prettier/vim-prettier'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'

" tools
Plug 'mhinz/vim-startify'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-obsession'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'jreybert/vimagit'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'cohama/lexima.vim'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-vdebug/vdebug'
Plug 'wellle/targets.vim'
Plug 'leafgarland/typescript-vim'
Plug '~/.brew/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" enable color scheme
set termguicolors
syntax enable               " enable syntax highlight
filetype indent plugin on
"let g:SnazzyTransparent = 1
colorscheme snazzy


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
set number                            " line number
set ls=2
set tabstop=2 shiftwidth=2 expandtab
set autoindent
set ruler
set incsearch                         " Start search before finish typing
set ignorecase                        " Make searching case insensitive
set smartcase                         " ... unless the query has capital letters.
set gdefault                          " Use 'g' flag by default with :s/foo/bar/.
set magic                             " Use 'magic' patterns (extended regular expressions).
set clipboard+=unnamedplus            " default to system clipboard
set autochdir
set hidden
set complete=.,w,b,u,t,i,kspell		    " `:set spell` to get completion from dictionary
set noshowmode                        " no show --Insert--, replaced by airline
let mapleader="\<SPACE>"

" speed up gitgutter
set updatetime=100 " 100ms

" tags http://vim.wikia.com/wiki/Browsing_programs_with_tags
"let g:gutentags_cache_dir=$HOME . '/.cache/ctags'

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('smart_case', v:true) " smart_case for match with capitals
" enable tab completion
inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" : "\<Tab>"

" tree style file explorer
let g:netrw_liststyle=3

" vim-airline configs
let g:airline#extensions#tabline#enabled = 1          " enable tabline
let g:airline#extensions#tabline#buffer_nr_show = 1   " display buffer number

" general keymap
xnoremap p pgvy
:command! BufOnly %bd|e#|bd#
nnoremap <C-L>  :bnext<CR>        " next buffer
nnoremap <C-H>  :bprevious<CR>    " previous buffer
nnoremap <Tab>  :b#<CR>           " last buffer

" fzf keymaps
" double <leader> to start fzf
nnoremap <silent> <Leader><Leader> :Files $PWD<CR>
nnoremap <silent> g] :Tags <C-R><C-W><CR>
" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
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
