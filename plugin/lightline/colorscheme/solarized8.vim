" https://ethanschoonover.com/solarized

let s:base03  = '#002b36'
let s:base02  = '#073642'
let s:base01  = '#586e75'
let s:base00  = '#657b83'
let s:base0   = '#839496'
let s:base1   = '#93a1a1'
let s:base2   = '#eee8d5'
let s:base3   = '#fdf6e3'

let s:cyan    = '#2aa198'
let s:blue    = '#268bd2'
let s:green   = '#859900'
let s:magenta = '#d33682'
let s:orange  = '#cb4b16'
let s:red     = '#dc322f'
let s:violet  = '#6c71c4'
let s:yellow  = '#b58900'

if &background ==# 'light'
  let [ s:base03, s:base3 ] = [ s:base3, s:base03 ]
  let [ s:base02, s:base2 ] = [ s:base2, s:base02 ]
  let [ s:base01, s:base1 ] = [ s:base1, s:base01 ]
  let [ s:base00, s:base0 ] = [ s:base0, s:base00 ]
endif

function! s:create_palette() abort
  let l:p = { 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'command': {} }

  let l:p.normal.left     = [ [ s:base03, s:base00 ], [ s:base03, s:base01 ] ]
  let l:p.normal.middle   = [ [ s:base01, s:base03 ] ]
  let l:p.normal.right    = l:p.normal.left

  let l:p.inactive.left   = [ l:p.normal.middle[0], l:p.normal.middle[0] ]
  let l:p.inactive.middle = l:p.inactive.left
  let l:p.inactive.right  = l:p.inactive.left

  let l:p.insert.left     = [ [ l:p.normal.left[0][0], s:blue ], l:p.normal.left[1] ]
  let l:p.replace.left    = [ [ l:p.normal.left[0][0], s:orange ], l:p.normal.left[1] ]
  let l:p.visual.left     = [ [ l:p.normal.left[0][0], s:green ], l:p.normal.left[1] ]
  let l:p.command.left    = [ [ l:p.normal.left[0][0], s:cyan ], l:p.normal.left[1] ]

  let l:p.normal.error    = [ [ l:p.normal.left[0][0], s:red ] ]
  let l:p.normal.warning  = [ [ l:p.normal.left[0][0], s:yellow ] ]

  return l:p
endfunction

let g:lightline#colorscheme#solarized8#palette = lightline#colorscheme#fill(s:create_palette())

