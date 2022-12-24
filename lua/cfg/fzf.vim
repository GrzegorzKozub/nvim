scriptencoding 'utf-8'

if has('win32')

  function! s:get_hi(group, key) abort
    return matchstr(execute('hi ' . a:group), a:key . '=\zs\S*')
  endfunction

  function! s:set_fzf_defaults() abort
    let l:comment_fg = s:get_hi('Comment', 'guifg')
    let l:inc_search_fg = s:get_hi('IncSearch', 'guifg')
    let l:string_fg = s:get_hi('String', 'guifg')
    let l:normal_fg = s:get_hi('Normal', 'guifg')
    let l:normal_bg = s:get_hi('Normal', 'guibg')
    let l:underlined_fg = s:get_hi('Underlined', 'guifg')
    let $FZF_DEFAULT_OPTS = '--color bg:' . l:normal_bg . ',bg+:' . l:normal_bg . ',border:' . l:comment_fg . ',fg:' . l:comment_fg . ',fg+:' . l:normal_fg . ',header:' . l:string_fg . ',hl:' . l:inc_search_fg . ',hl+:' . l:inc_search_fg . ',info:' . l:comment_fg . ',marker:' . l:normal_fg . ',pointer:' . l:normal_fg . ',prompt:' . l:underlined_fg
  endfunction

  augroup SetFZFDefaultsWhenColorSchemeChanges
    autocmd!
    autocmd ColorScheme * call s:set_fzf_defaults()
  augroup END

  let s:marker = '>'
  let s:pointer = '>'
  let s:prompt = ' > '

else

  let g:fzf_colors = {
    \ 'bg':      [ 'bg', 'Normal' ],
    \ 'bg+':     [ 'bg', 'Normal' ],
    \ 'border':  [ 'fg', 'Comment' ],
    \ 'fg':      [ 'fg', 'Comment' ],
    \ 'fg+':     [ 'fg', 'Normal' ],
    \ 'header':  [ 'fg', 'Keyword' ],
    \ 'hl':      [ 'fg', 'IncSearch' ],
    \ 'hl+':     [ 'fg', 'IncSearch' ],
    \ 'info':    [ 'fg', 'Comment' ],
    \ 'marker':  [ 'fg', 'Normal' ],
    \ 'pointer': [ 'fg', 'Normal' ],
    \ 'prompt':  [ 'fg', 'Underlined' ]
  \ }

  let s:marker = '•'
  let s:pointer = '●'
  let s:prompt = ' ●• '

endif

let s:options = [ '--marker', s:marker, '--no-bold', '--no-info', '--pointer', s:pointer, '--prompt' ]

command! -bang -nargs=? -complete=dir Buffers
  \ call fzf#vim#buffers(<q-args>, { 'options': s:options + [ 'buffers' . s:prompt ] }, <bang>0)
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <C-b> :Buffers<CR>

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, { 'options': s:options + [ 'files' . s:prompt ] }, <bang>0)
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <C-p> :Files<CR>

command! -bang -nargs=? -complete=dir History
  \ call fzf#vim#history({ 'options': s:options + [ 'history' . s:prompt ] }, <bang>0)
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <C-k> :History<CR>

command! -bang -nargs=? -complete=dir Commands
  \ call fzf#vim#command_history({ 'options': s:options + [ 'commands' . s:prompt ] }, <bang>0)
nnoremap <silent> <Leader>fc :Commands<CR>

command! -bang -nargs=? -complete=dir Searches
  \ call fzf#vim#search_history({ 'options': s:options + [ 'searches' . s:prompt ] }, <bang>0)
nnoremap <silent> <Leader>fs :Searches<CR>

