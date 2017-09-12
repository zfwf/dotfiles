" init.vim file, Chris Chou, chhschou@gmail.com

colorscheme solarized8_dark_high
set termguicolors						" enable color scheme	

syntax enable 							" enable syntax highlight
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣ 
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor-blinkwait1-blinkon15-blinkoff10,r-cr:hor20-Cursor/rCursor

filetype indent plugin on

set number		" line number
set ls=2
set tabstop=2
set shiftwidth=2
set autoindent
set ruler
set incsearch
set ignorecase
set clipboard+=unnamedplus "default to system clipboard

" status line
let g:airline#extensions#tabline#enabled = 1							" use powerline font in airline (statusline)

" vim-plug
call plug#begin('./plugged')
Plug 'w0rp/ale'
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-commentary'
Plug 'cohama/lexima.vim'
Plug 'vim-airline/vim-airline'
call plug#end()
