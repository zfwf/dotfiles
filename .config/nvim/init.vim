" init.vim file, Chris Chou, chhschou@gmail.com
let g:python3_host_prog = trim(system("echo $(pyenv root)/versions/neovim3/bin/python"))

" leader key
let mapleader="\<SPACE>"

" speed up diagnostics/gitgutter
set updatetime=100 " 100ms

" vim-plug (plugin only available after plug#end)
call plug#begin('~/.config/nvim/plugged')

Plug 'takac/vim-hardtime'   " no rep

" completion, extensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" #visual/info
Plug 'hzchirs/vim-material'

Plug 'vim-airline/vim-airline'

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

" enable colorscheme
syntax enable
filetype indent plugin on
set background=dark
colorscheme vim-material
let g:airline_theme = 'material' " airline theme


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

" load rest of the configs
runtime! init.d/*.vim
