" https://github.com/morhetz/gruvbox

let s:neutral_red    = '#cc241d' " 01
let s:neutral_green  = '#98971a' " 02
let s:neutral_yellow = '#d79921' " 03
let s:neutral_blue   = '#458588' " 04
let s:neutral_purple = '#b16286' " 05
let s:neutral_aqua   = '#689d6a' " 06

let s:neutral_gray   = '#928374' " 08

let s:neutral_orange = '#d65d0e'

if &background ==# 'dark'

  let s:bg0_h  = '#1d2021'
  let s:bg0    = '#282828'
  let s:bg0_s  = '#32302f'

  let s:bg1    = '#3c3836'
  let s:bg2    = '#514945'
  let s:bg3    = '#665c54'
  let s:bg4    = '#7c6f64'

  let s:fg0    = '#fbf1c7'
  let s:fg1    = '#ebdbb2'
  let s:fg2    = '#d5c4a1'
  let s:fg3    = '#bdae93'
  let s:fg4    = '#a89984'

  let s:bg     = '#282828' " 00

  let s:gray   = '#a89984' " 07

  let s:red    = '#fb4934' " 09
  let s:green  = '#b8bb26' " 10
  let s:yellow = '#fabd2f' " 11
  let s:blue   = '#83a598' " 12
  let s:purple = '#d3869b' " 13
  let s:aqua   = '#8ec07c' " 14
  let s:fg     = '#ebdbb2' " 15

  let s:orange = '#fe8019'

else

  let s:bg0_h  = '#f9f5d7'
  let s:bg0    = '#fbf1c7'
  let s:bg0_s  = '#f2e5bc'

  let s:bg1    = '#ebdbb2'
  let s:bg2    = '#d5c4a1'
  let s:bg3    = '#bdae93'
  let s:bg4    = '#a89984'

  let s:fg0    = '#282828'
  let s:fg1    = '#3c3836'
  let s:fg2    = '#504945'
  let s:fg3    = '#665c54'
  let s:fg4    = '#7c6f64'

  let s:bg     = '#fbf1c7' " 00

  let s:gray   = '#7c6f64' " 07

  let s:red    = '#9d0006' " 09
  let s:green  = '#79740e' " 10
  let s:yellow = '#b57614' " 11
  let s:blue   = '#076678' " 12
  let s:purple = '#8f3f71' " 13
  let s:aqua   = '#427b58' " 14
  let s:fg     = '#3c3836' " 15

  let s:orange = '#af3a03'

endif

exec 'hi ALEWarningSign guifg=' . s:yellow
exec 'hi CursorLineNr guifg=' . s:bg4
exec 'hi ErrorMsg guifg=' . s:red . ' guibg=' . s:bg0_h . ' gui=NONE cterm=NONE'
exec 'hi Folded guifg=' . s:bg4 . ' guibg=' . s:bg0_h
exec 'hi Normal guifg=' . s:fg2 . ' guibg=' . s:bg0_h
exec 'hi SignColumn guibg=' . s:bg0_h
exec 'hi SpecialKey guifg=' . s:green . ' gui=NONE cterm=NONE'
exec 'hi StatusLine guifg=' . s:bg4 . ' guibg=' . s:bg0_h . ' gui=NONE cterm=NONE'
exec 'hi StatusLineNC guifg=' . s:bg0_h
exec 'hi Terminal guifg=' . s:fg2 . ' guibg=' . s:bg0_h . ' gui=NONE cterm=NONE'
exec 'hi Todo guifg=' . s:neutral_gray . ' gui=NONE cterm=NONE'
exec 'hi Visual guifg=NONE guibg=' . s:bg1 . ' gui=NONE cterm=NONE'
exec 'hi WildMenu guifg=' . s:fg2 . ' guibg=' . s:bg0_h . ' gui=NONE cterm=NONE'

hi Directory gui=NONE cterm=NONE
hi Error gui=NONE cterm=NONE
hi Function gui=NONE cterm=NONE
hi MarkdownLinkText gui=NONE cterm=NONE
hi MatchParen gui=NONE cterm=NONE
hi ModeMsg gui=NONE cterm=NONE
hi MoreMsg gui=NONE cterm=NONE
hi NonText gui=NONE cterm=NONE
hi Question gui=NONE cterm=NONE
hi WarningMsg gui=NONE cterm=NONE
hi Title gui=NONE cterm=NONE
hi Underlined gui=NONE cterm=NONE

