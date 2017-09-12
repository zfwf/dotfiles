" vim: set tw=79 shiftwidth=2 tabstop=2 :
" vimrc file, Chris Chou, chhschou@gmail.com

colorscheme solarized8_dark_high
"let g:solarized_termtrans=1 " transparent background
"let g:solarized_termcolors=16
syntax enable

filetype indent plugin on
set termguicolors
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" set list
set nocompatible		" use vim defaults
set number					" enable line numbers
set ls=2						" always show status line
set tabstop=2
set shiftwidth=2		" set tabstop and shiftwidth for hard tab
set autoindent			" use autoindent
set showcmd					" show incomplete commands
set hlsearch				" highlight searches
set incsearch				" do incremental searching
set ruler						" show cursor position
set ignorecase			" set ignore case when searching
set modeline				" first or last lines in document sets vim mode
set modelines=3			" number lines checked for modelines
set nostartofline		" done jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]	" move freely between files
set clipboard+=unnamedplus	" to default to system clipboard

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-commentary'
Plug 'cohama/lexima.vim'
Plug 'vim-airline/vim-airline'
Plug 'jszakmeister/vim-togglecursor'

call plug#end()

