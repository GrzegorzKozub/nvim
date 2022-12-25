scriptencoding 'utf-8'

" options

let g:lightline = {
  \ 'active': {
    \ 'left': [
      \ [ 'mode', 'paste' ],
      \ [ 'buffer' ],
      \ [ 'filename' ]
    \ ],
    \ 'right': [
      \ [ 'aleerror', 'alewarning', 'fileposition' ],
      \ [ 'fileencodingandformat' ],
      \ [ 'filetype' ]
    \ ]
  \ },
  \ 'inactive' : { 'left': [ [ 'filename' ] ], 'right': [ [ 'filetype' ] ] },
  \ 'component_function': {
    \ 'buffer': 'g:LightLineBuffer',
    \ 'filename': 'g:LightLineFileName',
    \ 'filetype': 'g:LightLineFileType',
    \ 'fileencodingandformat': 'g:LightLineFileEncodingAndFormat',
    \ 'fileposition': 'g:LightLineFilePosition'
  \ },
  \ 'component_expand': {
    \ 'aleerror': 'LightLineALEError',
    \ 'alewarning': 'LightLineALEWarning'
  \ },
  \ 'component_type': { 'aleerror': 'error', 'alewarning': 'warning' },
  \ 'colorscheme': g:colors_name,
  \ 'mode_map': {
    \ 'n' : 'n',
    \ 'i' : 'i',
    \ 'c' : 'c',
    \ 'v' : 'v', 'V' : 'v', "\<C-v>": 'v',
    \ 's' : 's', 'S' : 's', "\<C-s>": 's',
    \ 'R' : 'r',
    \ 't': 't'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '|', 'right': '|' },
  \ 'enable': { 'tabline': 0 },
\ }

" component functions

function! g:LightLineBuffer() abort
  if &filetype =~? 'help\|netrw\|qf\|packer' | return '' | endif
  return bufnr('%')
endfunction

function! g:LightLineFileName() abort
  if &filetype =~? 'qf\|packer' | return '' | endif
  let l:filename = expand('%:t') ==# '' ? 'untitled' : expand('%:t')
  return l:filename . (&modified ? ' ●' : '')
endfunction

function! g:LightLineFileType() abort
  return &filetype
endfunction

function! g:LightLineFileEncodingAndFormat() abort
  if &filetype =~? 'help\|netrw\|qf\|packer' | return '' | endif
  return &fileencoding . (strlen(&fileencoding) > 0 ? ' ' : '') . (&fileformat ==# 'unix' ? 'lf' : 'crlf')
endfunction

function! g:LightLineFilePosition() abort
  return printf('%d%% %d %d', (100 * line('.') / line('$')), line('.'), col('.'))
endfunction

function! s:lightline_format_ale_icon(count, icon) abort
  return a:count > 0 ? a:icon . ' ' . a:count : ''
endfunction

function! s:get_ale_counts() abort
  return ale#statusline#Count(bufnr('%'))
endfunction

function! g:LightLineALEError() abort
  return s:lightline_format_ale_icon(s:get_ale_counts().error, '●')
endfunction

function! g:LightLineALEWarning() abort
  return s:lightline_format_ale_icon(s:get_ale_counts().warning, '▲')
endfunction

" ALE integration

augroup UpdateLightLineWhenALELints
  autocmd!
  autocmd User ALEFixPost call lightline#update()
  autocmd User ALEJobStarted call lightline#update()
  autocmd User ALELintPost call lightline#update()
augroup END

" reload on color scheme change

function! s:reload_lightline() abort
  if !exists('g:loaded_lightline') | return | endif
  let g:lightline.colorscheme = g:colors_name
  call lightline#enable()
endfunction

augroup ReloadLightLineWhenColorSchemeChanges
  autocmd!
  autocmd ColorScheme * call s:reload_lightline()
augroup END

