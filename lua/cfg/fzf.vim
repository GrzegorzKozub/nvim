scriptencoding 'utf-8'

let s:options = [
  \ '--no-bold', '--no-info', '--no-mouse', '--no-separator',
  \ '--info', 'hidden'
\ ]

if has('win32')

  function! s:get_hi(group, key) abort
    return matchstr(execute('hi ' . a:group), a:key . '=\zs\S*')
  endfunction

  let s:comment_fg = s:get_hi('Comment', 'guifg')
  let s:identifier_fg = s:get_hi('Identifier', 'guifg')
  let s:inc_search_bg = s:get_hi('IncSearch', 'guibg')
  let s:line_nr_fg = s:get_hi('LineNr', 'guifg')
  let s:normal_bg = s:get_hi('Normal', 'guibg')
  let s:normal_fg = s:get_hi('Normal', 'guifg')
  let s:number_fg = s:get_hi('Number', 'guifg')
  let s:search_bg = s:get_hi('Search', 'guibg')

  let s:color = [
    \ '--color=',
    \ 'bg:' . s:normal_bg,
    \ ',bg+:' . s:normal_bg,
    \ ',border:' . s:line_nr_fg,
    \ ',fg:' . s:comment_fg,
    \ ',fg+:' . s:normal_fg,
    \ ',header:' . s:identifier_fg,
    \ ',hl:' . s:search_bg,
    \ ',hl+:' . s:inc_search_bg,
    \ ',info:' . s:comment_fg,
    \ ',marker:' . s:normal_fg,
    \ ',pointer:' . s:normal_fg,
    \ ',prompt:' . s:number_fg
  \ ]

  call add(s:options, join(s:color, ''))

  let s:marker = '>'
  let s:pointer = '>'
  let s:prompt = ' > '

else

  let g:fzf_colors = {
    \ 'bg':      [ 'bg', 'Normal' ],
    \ 'bg+':     [ 'bg', 'Normal' ],
    \ 'border':  [ 'fg', 'LineNr' ],
    \ 'fg':      [ 'fg', 'Comment' ],
    \ 'fg+':     [ 'fg', 'Normal' ],
    \ 'header':  [ 'fg', 'Identifier' ],
    \ 'hl':      [ 'bg', 'Search' ],
    \ 'hl+':     [ 'bg', 'IncSearch' ],
    \ 'info':    [ 'fg', 'Comment' ],
    \ 'marker':  [ 'fg', 'Normal' ],
    \ 'pointer': [ 'fg', 'Normal' ],
    \ 'prompt':  [ 'fg', 'Number' ]
  \ }

  let s:marker = '•'
  let s:pointer = '●'
  let s:prompt = ' ●• '

endif

call extend(s:options, [
  \ '--pointer', s:pointer,
  \ '--marker', s:marker,
  \ '--prompt'
\ ])

command! -bang -nargs=? -complete=dir Buffers
  \ call fzf#vim#buffers(<q-args>, { 'options': s:options + [ 'buffers' . s:prompt ] }, <bang>0)
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <c-b> :Buffers<CR>

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, { 'options': s:options + [ 'files' . s:prompt ] }, <bang>0)
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <c-p> :Files<CR>

command! -bang -nargs=? -complete=dir History
  \ call fzf#vim#history({ 'options': s:options + [ 'history' . s:prompt ] }, <bang>0)
nnoremap <silent> <leader>fh :History<CR>
nnoremap <silent> <c-k> :History<CR>

command! -bang -nargs=? -complete=dir Commands
  \ call fzf#vim#command_history({ 'options': s:options + [ 'commands' . s:prompt ] }, <bang>0)
nnoremap <silent> <leader>fc :Commands<CR>

command! -bang -nargs=? -complete=dir Searches
  \ call fzf#vim#search_history({ 'options': s:options + [ 'searches' . s:prompt ] }, <bang>0)
nnoremap <silent> <leader>fs :Searches<CR>

