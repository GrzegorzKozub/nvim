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
let s:orange  = '#cb4b16'
let s:violet  = '#6c71c4'
let s:yellow  = '#b58900'

if &background ==# 'light'
  let [ s:base03, s:base3 ] = [ s:base3, s:base03 ]
  let [ s:base02, s:base2 ] = [ s:base2, s:base02 ]
  let [ s:base01, s:base1 ] = [ s:base1, s:base01 ]
  let [ s:base00, s:base0 ] = [ s:base0, s:base00 ]
endif

exec 'hi ALEErrorSign guifg=' . s:red . ' guibg=NONE'
exec 'hi ALEWarningSign guifg=' . s:yellow . ' guibg=NONE'
exec 'hi Cursor guifg=' . s:base03 . ' guibg=' . s:orange
exec 'hi CursorLineNr guifg=' . s:base0 . ' guibg=' . s:base02 . ' gui=NONE cterm=NONE'
exec 'hi Folded guifg=' . s:base00 . ' guibg=' . s:base03 . ' gui=NONE cterm=NONE'
exec 'hi LineNr guibg=' . s:base03
exec 'hi SignColumn guibg=' . s:base03
exec 'hi MatchParen guifg=' . s:orange . ' gui=NONE cterm=NONE'
exec 'hi SpecialKey guifg=' . s:cyan . ' gui=NONE cterm=NONE'
exec 'hi StatusLine guifg=' . s:base01 . ' guibg=' . s:base03 . ' gui=NONE cterm=NONE'
exec 'hi StatusLineNC guifg=' . s:base03
exec 'hi Todo guifg=' . s:base01 . ' gui=NONE cterm=NONE'
exec 'hi VertSplit guifg=' . s:base03 . ' guibg=' . s:base03
exec 'hi Visual guifg=NONE guibg=' . s:base02 . ' gui=NONE cterm=NONE'
exec 'hi WildMenu guifg=' . s:base0 . ' guibg=' . s:base03 . ' gui=NONE cterm=NONE'

hi Error gui=NONE cterm=NONE guibg=NONE
hi ErrorMsg gui=NONE cterm=NONE guibg=NONE
hi IncSearch gui=reverse cterm=reverse
hi NonText gui=NONE cterm=NONE
hi Question gui=NONE cterm=NONE
hi WarningMsg gui=NONE cterm=NONE
"hi Title gui=NONE cterm=NONE
hi Underlined gui=NONE cterm=NONE

