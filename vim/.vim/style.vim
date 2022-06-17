Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'posva/vim-vue'
Plug 'udalov/kotlin-vim'
Plug 'peterhoeg/vim-qml'
call plug#end()

set termguicolors bg=dark statusline=%1*\ \%f%m\ %0*%= 

for c in ["BG", "LIGHT_BG", "LIGHTER_BG", "LIGHTEST_BG"]
  exe 'if !empty($'.c.')|let '.c.'=$'.c.'|else|let '.c.'="black"|endif'
endfor

exe 'hi ActiveWin guibg='.BG
exe 'hi CursorLine gui=none guibg='.LIGHT_BG
exe 'hi CursorLineNr gui=none guifg=default guibg='.LIGHTER_BG
exe 'hi DiffAdd gui=none guifg=none guibg='.LIGHTEST_BG
exe 'hi DiffChange gui=none guifg=none guibg='.LIGHTER_BG
exe 'hi DiffDelete gui=none guifg=none guibg='.LIGHTEST_BG
exe 'hi DiffText gui=none guifg=none guibg='.LIGHTEST_BG
exe 'hi FloatermBorder guibg='.BG.' guifg=default'
exe 'hi InactiveWin guibg='.LIGHT_BG
exe 'hi LineNr guifg=darkgray guibg='.LIGHTER_BG
exe 'hi NonText guifg='.LIGHTEST_BG
exe 'hi Normal guibg='.LIGHTER_BG
exe 'hi Pmenu gui=none guifg=default guibg='.LIGHTEST_BG
exe 'hi PmenuSel gui=none guifg=default guibg='.LIGHTER_BG
exe 'hi StatusLine gui=underline guifg=default guibg='.BG
exe 'hi StatusLineNC gui=underline guifg=default guibg='.LIGHT_BG
exe 'hi User1 gui=none guifg=default guibg='.LIGHTEST_BG
exe 'hi VertSplit gui=none guifg=default guibg='.LIGHT_BG
exe 'hi Visual guifg=black guibg=lightgrey'

exe 'hi BufferTabpageFill guibg='.LIGHTER_BG
for v in ["", "Mod","Index","Sign"]
  exe 'hi BufferCurrent'.v.' guibg='.LIGHT_BG
  for k in ["Inactive", "Visible"]
    exe 'hi Buffer'.k.v.' guibg='.LIGHTEST_BG
  endfor
endfor

autocmd FocusLost * setlocal winhighlight=Normal:InactiveWin
autocmd BufNew,BufLeave,BufRead,FocusGained * setlocal
  \ winhighlight=Normal:ActiveWin,NormalNC:InactiveWin
