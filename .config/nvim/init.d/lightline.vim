set hidden  " allow buffer switching without saving
set showtabline=2  " always show tabline

" use lightline-buffer in lightline
let g:lightline = {
      \ 'colorscheme': 'material_vim',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly' ],
      \           ],
      \   'right': [
      \             [ 'cocwarning', 'cocerror' ],
      \             [ 'fileformat', 'fileencoding', 'filetype', 'percent', 'lineinfo' ],
      \            ],
      \ },
      \ 'tabline': {
      \   'left': [ [ 'bufferinfo' ],
      \             [ 'separator' ],
      \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
      \   'right': [ [ 'close' ], ],
      \ },
      \ 'component_type': {
      \   'buffercurrent': 'tabsel',
      \   'bufferbefore': 'raw',
      \   'bufferafter': 'raw',
      \   'cocerror': 'error',
      \   'cocwarning' : 'warning',
      \ },
      \ 'component_expand': {
      \   'buffercurrent': 'lightline#buffer#buffercurrent',
      \   'bufferbefore': 'lightline#buffer#bufferbefore',
      \   'bufferafter': 'lightline#buffer#bufferafter',
      \   'cocerror':    'LightlineCocErrorCnt',
      \   'cocwarning':  'LightlineCocWarningCnt',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'fug': 'FugitiveStatusline',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'bufferinfo': 'lightline#buffer#bufferinfo',
      \   'arglist':      'LightlineArglist',
      \   'fugitive':     'LightlineFugitive',
      \   'gitversion':   'LightlineGitversion',
      \   'mode':         'LightlineMode',
      \ },
      \ 'component': {
      \   'separator': '',
      \   'lineinfo': ' %3l:%-2v',
      \ },
      \ 'mode_map' : {
      \   'n' : 'N',
      \   'i' : 'I',
      \   'R' : 'R',
      \   'v' : 'V',
      \   'V' : 'V-LINE',
      \   "\<C-v>": 'V-BLOCK',
      \   'c' : 'C',
      \   's' : 'S',
      \   'S' : 'S-LINE',
      \   "\<C-s>": 'S-BLOCK',
      \   't' : 'T',
      \ },
      \ }


let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': ''
  \}

function! LightlineMode()
  let fname = expand('%:t')
  if &ft == 'denite'
    let mode_str = substitute(denite#get_status_mode(), "-\\| ", "", "g")
    call lightline#link(tolower(mode_str[0]))
    return mode_str
  else
  return
        \ fname == 'ControlP' ? 'CtrlP' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
  endif
endfunction

function! LightlineFugitive()
 try
    if expand('%:t') !~? 'Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let branch = fugitive#head()
      return branch !=# '' ? ' '.branch : ''
    endif
  catch
  endtry
  return ''
endfunction


let s:error_symbol = '✘'
let s:warning_symbol = ''
function! LightlineCocErrorCnt()
  return LightlineCocDiagCnt('error')
endfunction
function! LightlineCocWarningCnt()
  return LightlineCocDiagCnt('warning')
endfunction

function! LightlineCocDiagCnt(type)
  if !exists(":CocCommand")
    return ''
  endif
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif

  let is_err = (a:type  is# 'error')
  let cnt = get(info, a:type, 0)
  if empty(cnt)
    return ''
  else
    return (is_err ? s:error_symbol : s:warning_symbol).cnt
  endif
endfunction


function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

au User CocDiagnosticChange call lightline#update() " force lightline update on chc diag change


" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not support unicode
let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '  '

" enable devicons, only support utf-8
" require <https://github.com/ryanoasis/vim-devicons>
let g:lightline_buffer_enable_devicons = 1

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1

" :help filename-modifiers
let g:lightline_buffer_fname_mod = ':t'

" hide buffer list
let g:lightline_buffer_excludes = ['vimfiler']

" max file name length
let g:lightline_buffer_maxflen = 30

" max file extension length
let g:lightline_buffer_maxfextlen = 3

" min file name length
let g:lightline_buffer_minflen = 16

" min file extension length
let g:lightline_buffer_minfextlen = 3

" reserve length for other component (e.g. info, close)
let g:lightline_buffer_reservelen = 20
