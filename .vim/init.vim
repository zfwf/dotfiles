" init.vim file, Chris Chou, zf8wf8@petalmail.com

" mapping delay 1000, key code delay 0
" set timeoutlen=1000 ttimeoutlen=0

" leader key
let mapleader="\<SPACE>"

if !exists('g:vscode')
  " speed up diagnostics/gitgutter
  set updatetime=100 " 100ms

  " vim-plug (plugin only available after plug#end)
  call plug#begin()

  " completion, extensions
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " #visual/info
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'itchyny/lightline.vim'
  Plug 'taohexxx/lightline-buffer'
  Plug 'ryanoasis/vim-devicons'
  Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' } " tree-sitter
  " colored parentheses
  Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1

  " #tools:VCS
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'

  " #tools:misc --------
  " fold
  Plug 'pseewald/vim-anyfold'
  " `gc` comments
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  " auto close/surround text
  Plug 'jiangmiao/auto-pairs'
  "Plug 'cohama/lexima.vim'
  " word motion
  Plug 'easymotion/vim-easymotion'
  map <Leader>e <Plug>(easymotion-prefix)
  " Plug 'chaoren/vim-wordmotion'
  " sessions
  Plug 'tpope/vim-obsession'
  " additional text obj
  Plug 'wellle/targets.vim'
  " #-------------------
  call plug#end()

  set termguicolors

  " enable colorscheme
  syntax enable
  filetype indent plugin on
  set background=dark
  colorscheme dracula


  " show whitespace characters
  set list
  set listchars=tab:>\ ,trail:~,extends:>,precedes:<
  " highlight trailing whitespace and spaces before a tab
  highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
  match ExtraWhitespace /\s\+$\| \+\ze\t/

  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor-blinkwait1-blinkon15-blinkoff10,r-cr:hor20-Cursor/rCursor
  set mouse=a
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
  call plug#begin()
    " `gc` comments
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    " word motion
    " Plug 'chaoren/vim-wordmotion'
    " additional text obj
    Plug 'wellle/targets.vim'
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
