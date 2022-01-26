let BG="#282a36"|let BG1="#383A46"|let BG2="#494B57"|let BG3="#696B77"
set bg=dark
set termguicolors
set statusline=%1*\ \%f%m\ %0*%= 

exe 'hi ActiveWin guibg='.BG
exe 'hi CursorLine gui=none guibg='.BG1
exe 'hi CursorLineNr gui=none guifg=default guibg='.BG2
exe 'hi DiffAdd gui=none guifg=none guibg='.BG3
exe 'hi DiffChange gui=none guifg=none guibg='.BG2
exe 'hi DiffDelete gui=none guifg=none guibg='.BG3
exe 'hi DiffText gui=none guifg=none guibg='.BG3
exe 'hi FloatermBorder guibg='.BG.' guifg=default'
exe 'hi InactiveWin guibg='.BG1
exe 'hi LineNr gui=bold guifg='.BG3.' guibg='.BG2
exe 'hi NonText guifg='.BG3
exe 'hi Normal guibg='.BG2
exe 'hi Pmenu gui=none guifg=default guibg='.BG3
exe 'hi PmenuSel gui=none guifg=default guibg='.BG2
exe 'hi StatusLine gui=underline guifg=default guibg='.BG
exe 'hi StatusLineNC gui=underline guifg=default guibg='.BG1
exe 'hi User1 gui=none guifg=default guibg='.BG3
exe 'hi VertSplit gui=none guifg=default guibg='.BG1
exe 'hi Visual guifg=#000000 guibg=#c4c4c4'

exe 'hi BufferTabpageFill guibg='.BG2
for v in ["", "Mod","Index","Sign"]
  exe 'hi BufferCurrent'.v.' guibg='.BG2
  for k in ["Inactive", "Visible"]
    exe 'hi Buffer'.k.v.' guibg='.BG3
  endfor
endfor

autocmd FocusLost * setlocal winhighlight=Normal:InactiveWin
autocmd BufNew,BufLeave,BufRead,FocusGained * setlocal
  \ winhighlight=Normal:ActiveWin,NormalNC:InactiveWin
