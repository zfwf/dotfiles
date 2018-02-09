" init.vim file, Chris Chou, chhschou@gmail.com

" vim-plug (plugin only available after plug#end)
call plug#begin('~/.config/nvim/plugged')
Plug 'w0rp/ale'
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-commentary'
Plug 'cohama/lexima.vim'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mhinz/vim-startify'
call plug#end()

" enable color scheme
colorscheme solarized8_dark_high
set termguicolors
syntax enable               " enable syntax highlight
filetype indent plugin on

" show whitespace characters
set list
set listchars=tab:>\ ,trail:~,extends:>,precedes:<
" highlight trailing whitespace and spaces before a tab
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\| \+\ze\t/

" set cursor
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor-blinkwait1-blinkon15-blinkoff10,r-cr:hor20-Cursor/rCursor

set inccommand=nosplit
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
let mapleader="\<SPACE>"

" use powerline font in airline (statusline)
let g:airline#extensions#tabline#enabled = 1

" CtrlP options
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|node_modules|log|tmp',
  \ 'file': '\v\.(exe|so|dll|DS_Store|dat)$',
  \ }

" keymap
xnoremap p pgvy

" auto commands (see :h autocommand-events)
au BufLeave * silent! wall
