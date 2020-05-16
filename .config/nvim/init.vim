" init.vim file, Chris Chou, chhschou@gmail.com

" mapping delay 1000, key code delay 0
set timeoutlen=1000 ttimeoutlen=0

" leader key
let mapleader="\<SPACE>"

if !exists('g:vscode')
  " python3 support
  let g:python3_host_prog="~/.asdf/installs/python/3.8.2/bin/python"

  " speed up diagnostics/gitgutter
  set updatetime=100 " 100ms

  " vim-plug (plugin only available after plug#end)
  call plug#begin('~/.config/nvim/plugged')

  " no rep of hjkl
  Plug 'takac/vim-hardtime'
  let g:hardtime_default_on = 1

  " completion, extensions
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " #visual/info
  Plug 'kaicataldo/material.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'taohexxx/lightline-buffer'
  Plug 'ryanoasis/vim-devicons'
  Plug 'airblade/vim-gitgutter'
  Plug 'sheerun/vim-polyglot'
  " colored parentheses
  Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1

  " #tools:VCS
  Plug 'jreybert/vimagit'
  Plug 'tpope/vim-fugitive'

  " #tools:misc --------
  " file manager
  Plug 'mcchrish/nnn.vim'
  " auto save sessions
  Plug 'tpope/vim-obsession'
  " `gc` comments
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  " auto close/surround text
  Plug 'cohama/lexima.vim'
  " additional text obj
  Plug 'wellle/targets.vim'
  " #-------------------
  call plug#end()

  " enable truecolor support
  " set t_8b=^[[48;2;%lu;%lu;%lum
  " set t_8f=^[[38;2;%lu;%lu;%lum
  set termguicolors

  " enable colorscheme
  syntax enable
  filetype indent plugin on
  set background=dark
  colorscheme material
  let g:material_terminal_italics = 1
  let g:material_theme_style = 'darker'


  " show whitespace characters
  set list
  set listchars=tab:>\ ,trail:~,extends:>,precedes:<
  " highlight trailing whitespace and spaces before a tab
  highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
  match ExtraWhitespace /\s\+$\| \+\ze\t/

  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor-blinkwait1-blinkon15-blinkoff10,r-cr:hor20-Cursor/rCursor
  set mouse=a
  set inccommand=nosplit
  set showcmd                           " show cmd used (bottom right)
  set number relativenumber             " hybrid line number
  set ls=2                              " always show status line
  set tabstop=2 shiftwidth=2 expandtab
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
else
  " vim-plug (plugin only available after plug#end)
  call plug#begin('~/.config/nvim/vscode-plugged')
    " no rep of hjkl
    Plug 'takac/vim-hardtime'
    let g:hardtime_default_on = 1

    " `gc` comments
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    " additional text obj
    " Plug 'wellle/targets.vim'
  call plug#end()

  set incsearch                         " Start search before finish typing
  set ignorecase                        " Make searching case insensitive
  set smartcase                         " ... unless the query has capital letters.
  set gdefault                          " Use 'g' flag by default with :s/foo/bar/.
  set magic                             " Use 'magic' patterns (extended regular expressions).
  set clipboard+=unnamedplus            " default to system clipboard

  " load rest of the configs
  runtime! init.d/*.vim
endif
