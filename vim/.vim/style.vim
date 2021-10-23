let BG="#282a36"
let LIGHT_BG="#363844"
set bg=dark

set cursorline!
set fillchars=eob: 
set termguicolors

set statusline=%1*\ %f%m\ %0*\%= 
execute 'highlight StatusLine gui=underline guifg=#888888 guibg='.BG
execute 'highlight StatusLineNC gui=underline guifg=#888888 guibg='.LIGHT_BG
highlight User1 gui=bold guifg=default guibg=#888888

execute 'highlight LineNr gui=none guifg=gray guibg='.LIGHT_BG
execute 'highlight CursorLineNr gui=none guifg=gray guibg='.BG
execute 'highlight ActiveWindow guibg='.BG
execute 'highlight InactiveWindow guibg='.LIGHT_BG
execute 'highlight CursorLine gui=none guibg='.LIGHT_BG
execute 'highlight VertSplit gui=none guifg=#888888 guibg='.LIGHT_BG

execute 'highlight DiffAdd gui=bold guifg=green guibg='.LIGHT_BG
execute 'highlight DiffText gui=bold guifg=green guibg='.LIGHT_BG
execute 'highlight DiffDelete gui=bold guifg=green guibg='.LIGHT_BG
execute 'highlight DiffChange gui=none guifg=none guibg='.LIGHT_BG

highlight PmenuSel gui=none guifg=#000000 guibg=#888888
highlight Pmenu gui=none guifg=#000000 guibg=#c4c4c4

highlight CocErrorFloat guifg=red guibg=#c4c4c4
highlight CocWarningFloat guifg=orange guibg=#c4c4c4
highlight CocHintFloat guifg=green guibg=#c4c4c4
highlight CocInfoFloat guifg=blue guibg=#c4c4c4
highlight CocErrorSign guifg=black guibg=red
highlight CocWarningSign guifg=black guibg=orange
highlight CocHintSign guifg=black guibg=green
highlight CocInfoSign guifg=black guibg=blue
highlight CocErrorHighlight gui=underline
highlight CocWarningHighlight gui=underline
highlight CocHintHighlight gui=underline
highlight CocInfoHighlight gui=underline

highlight Visual guifg=#000000 guibg=#c4c4c4

highlight FloatermBorder guibg=none guifg=#888888

autocmd BufNew,BufLeave,FocusGained * setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
autocmd FocusLost * setlocal winhighlight=Normal:InactiveWindow
