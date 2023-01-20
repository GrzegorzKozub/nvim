scriptencoding 'utf-8'

GuiFont Cascadia\ Code:h13
" GuiFont Fira\ Code\ Retina:h12

GuiRenderLigatures 1

nnoremap <silent> <f10> :call GuiWindowMaximized(!g:GuiWindowMaximized)<cr>
nnoremap <silent> <f11> :call GuiWindowFullScreen(!g:GuiWindowFullScreen)<cr>