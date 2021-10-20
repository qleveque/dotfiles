set fillchars=vert: ,eob: 
set statusline=\ %f%m\ %=%{noscrollbar#statusline(30,'━','◼')} 

highlight LineNr cterm=none ctermfg=white ctermbg=darkcyan
highlight CursorLineNr cterm=none ctermfg=white ctermbg=darkcyan
highlight VertSplit cterm=none ctermfg=black ctermbg=darkcyan
highlight StatusLine cterm=bold ctermfg=white ctermbg=darkcyan
highlight StatusLineNC cterm=bold ctermfg=white ctermbg=darkcyan
highlight Visual ctermfg=black ctermbg=blue
highlight DiffAdd cterm=none ctermfg=white ctermbg=darkblue
highlight DiffDelete cterm=none ctermfg=black ctermbg=none
highlight DiffChange cterm=none ctermfg=none ctermbg=none
highlight DiffText cterm=none ctermfg=white ctermbg=darkblue

highlight Pmenu ctermfg=black ctermbg=white
highlight PmenuSel ctermfg=black ctermbg=gray

highlight CocErrorFloat ctermbg=white ctermfg=red
highlight CocWarningFloat ctermbg=white ctermfg=black
highlight CocHintFloat ctermbg=white ctermfg=black
highlight CocInfoFloat ctermbg=white ctermfg=black

highlight CocErrorSign ctermbg=red
highlight CocWarningSign ctermbg=yellow
highlight CocHintSign ctermbg=blue
highlight CocInfoSign ctermbg=cyan

highlight CocErrorHighlight cterm=bold,underline
highlight CocWarningHighlight cterm=bold,underline
highlight CocHintHighlight cterm=bold,underline
highlight CocInfoHighlight cterm=bold,underline

hi FloatermBorder ctermfg=white ctermbg=darkblue

set bg=dark
