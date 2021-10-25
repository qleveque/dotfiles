let LIGHTER_BG="#525460"
let LIGHT_BG="#363844"
let BG="#282a36"
set bg=dark

set cursorline!
set fillchars=eob: 
set termguicolors
set statusline=%1*\ %{WebDevIconsGetFileTypeSymbol()}%2*\ %f%m\ %0*\%= 

execute 'highlight StatusLine gui=underline guifg='.LIGHTER_BG.' guibg='.BG
execute 'highlight StatusLineNC gui=underline guifg='.LIGHTER_BG.' guibg='.LIGHT_BG
execute 'highlight User1 gui=none guifg='.BG.' guibg='.LIGHTER_BG
execute 'highlight User2 gui=none guifg=default guibg='.LIGHTER_BG

execute 'highlight LineNr gui=none guifg=gray guibg='.LIGHT_BG
execute 'highlight CursorLineNr gui=none guifg=gray guibg='.BG
execute 'highlight ActiveWindow guibg='.BG
execute 'highlight InactiveWindow guibg='.LIGHT_BG
execute 'highlight CursorLine gui=none guibg='.LIGHT_BG
execute 'highlight VertSplit gui=none guifg='.LIGHTER_BG.' guibg='.LIGHT_BG

execute 'highlight DiffAdd gui=bold guifg=none guibg='.LIGHTER_BG
execute 'highlight DiffText gui=bold guifg=none guibg='.LIGHTER_BG
execute 'highlight DiffDelete gui=bold guifg=none guibg='.LIGHTER_BG
highlight DiffChange gui=none guifg=none guibg=none

execute 'highlight PmenuSel gui=none guifg=#000000 guibg='.LIGHTER_BG
highlight Pmenu gui=none guifg=#000000 guibg=#c4c4c4

highlight CocErrorFloat guifg=red guibg=#c4c4c4
highlight CocWarningFloat guifg=black guibg=#c4c4c4
highlight CocHintFloat guifg=green guibg=#c4c4c4
highlight CocInfoFloat guifg=blue guibg=#c4c4c4
highlight CocErrorSign guifg=black guibg=red
highlight CocWarningSign guifg=black guibg=orange
highlight CocHintSign guifg=black guibg=green
highlight CocInfoSign guifg=black guibg=blue
highlight CocErrorHighlight gui=undercurl guisp=red
highlight CocWarningHighlight gui=undercurl guisp=orange
highlight CocHintHighlight gui=undercurl guisp=green
highlight CocInfoHighlight gui=undercurl guisp=blue

highlight Visual guifg=#000000 guibg=#c4c4c4

execute 'highlight FloatermBorder guibg=none guifg='.LIGHTER_BG

autocmd BufNew,BufLeave,FocusGained * setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
autocmd FocusLost * setlocal winhighlight=Normal:InactiveWindow
