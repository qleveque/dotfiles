let LIGHTEST_BG="#575965"
let LIGHTER_BG="#3F414D"
let LIGHT_BG="#31333F"
let BG="#282a36"
set bg=dark

set termguicolors
set statusline=%1*\ %{WebDevIconsGetFileTypeSymbol()}\%m\ \%f\ %0*\%= 

highlight Visual guifg=#000000 guibg=#c4c4c4

execute 'highlight Normal guibg='.LIGHTER_BG
execute 'highlight StatusLine gui=underline guifg='.LIGHTEST_BG.' guibg='.BG
execute 'highlight StatusLineNC gui=underline guifg='.LIGHTEST_BG.' guibg='.LIGHT_BG
execute 'highlight User1 gui=none guifg=default guibg='.LIGHTEST_BG

execute 'highlight LineNr gui=none guifg=gray guibg='.LIGHTER_BG
execute 'highlight CursorLineNr gui=none guifg=gray guibg='.LIGHTER_BG
execute 'highlight ActiveWin guibg='.BG
execute 'highlight InactiveWin guibg='.LIGHT_BG
execute 'highlight CursorLine gui=none guibg='.LIGHT_BG
execute 'highlight VertSplit gui=none guifg='.LIGHTEST_BG.' guibg='.LIGHT_BG

execute 'highlight DiffAdd gui=none guifg=none guibg='.LIGHTEST_BG
execute 'highlight DiffText gui=none guifg=none guibg='.LIGHTEST_BG
execute 'highlight DiffDelete gui=none guifg=none guibg='.LIGHTEST_BG
execute 'highlight DiffChange gui=none guifg=none guibg='.LIGHTER_BG

execute 'highlight BufferCurrent guibg='.LIGHTER_BG
execute 'highlight BufferCurrentMod guibg='.LIGHTER_BG
execute 'highlight BufferCurrentIndex guibg='.LIGHTER_BG
execute 'highlight BufferCurrentSign guibg='.LIGHTER_BG
execute 'highlight BufferTabpageFill guibg='.LIGHTEST_BG
execute 'highlight BufferInactive guibg='.LIGHTEST_BG
execute 'highlight BufferInactiveMod guibg='.LIGHTEST_BG
execute 'highlight BufferInactiveIndex guibg='.LIGHTEST_BG
execute 'highlight BufferInactiveSign guibg='.LIGHTEST_BG
execute 'highlight BufferVisible guibg='.LIGHTEST_BG
execute 'highlight BufferVisibleMod guibg='.LIGHTEST_BG
execute 'highlight BufferVisibleIndex guibg='.LIGHTEST_BG
execute 'highlight BufferVisibleSign guibg='.LIGHTEST_BG

execute 'highlight PmenuSel gui=none guifg=default guibg='.LIGHTER_BG
execute 'highlight Pmenu gui=none guifg=default guibg='.LIGHTEST_BG

execute 'highlight NonText guifg='.LIGHTEST_BG

execute 'highlight FloatermBorder guibg='.BG.' guifg='.LIGHTEST_BG

highlight CocErrorFloat guifg=default
highlight CocWarningFloat guifg=default
highlight CocHintFloat guifg=default
highlight CocInfoFloat guifg=default
highlight CocErrorHighlight gui=undercurl guisp=red
highlight CocWarningHighlight gui=undercurl guisp=orange
highlight CocHintHighlight gui=undercurl guisp=green
highlight CocInfoHighlight gui=undercurl guisp=blue
execute 'highlight CocErrorSign guifg=red guibg='.LIGHTEST_BG
execute 'highlight CocWarningSign guifg=orange guibg='.LIGHTEST_BG
execute 'highlight CocHintSign guifg=green guibg='.LIGHTEST_BG
execute 'highlight CocInfoSign guifg=blue guibg='.LIGHTEST_BG

autocmd FocusLost * setlocal winhighlight=Normal:InactiveWin
autocmd BufNew,BufLeave,BufRead,FocusGained * setlocal
      \ winhighlight=Normal:ActiveWin,NormalNC:InactiveWin
