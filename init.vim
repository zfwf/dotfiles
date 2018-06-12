" init.vim file, Chris Chou, chhschou@gmail.com

" vim-plug (plugin only available after plug#end)
call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-unimpaired'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'cohama/lexima.vim'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-vdebug/vdebug'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wellle/targets.vim'
Plug 'leafgarland/typescript-vim'
Plug '~/.brew/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'szw/vim-maximizer'
call plug#end()

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('smart_case', v:true) " smart_case for match with capitals
" enable tab completion
inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" : deoplete#manual_complete()

" maximizer
let g:maximizer_default_mapping_key = '<F3>'

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
let mapleader="\<SPACE>"

" use powerline font in airline (statusline)
let g:airline#extensions#tabline#enabled = 1

" CtrlP options
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|node_modules|log|tmp',
  \ 'file': '\v\.(exe|so|dll|DS_Store|dat)$',
  \ }

" general keymap
xnoremap p pgvy

" fzf keymaps
nnoremap <silent> <Leader><Leader> :Files <C-R>=expand('%:h')<CR><CR>

" auto commands (see :h autocommand-events)
au BufLeave * silent! wall

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
