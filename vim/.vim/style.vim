set bg=dark
set fillchars=vert: ,eob: 
set statusline=\ %f%m\ %=%{noscrollbar#statusline(30,'━','◼')} 
highlight LineNr cterm=none ctermfg=white ctermbg=darkcyan
highlight CursorLineNr cterm=none ctermfg=white ctermbg=darkcyan
highlight VertSplit cterm=none ctermfg=black ctermbg=darkcyan
highlight StatusLine cterm=bold ctermfg=white ctermbg=darkcyan
highlight StatusLineNC cterm=bold ctermfg=white ctermbg=darkcyan
highlight DiffAdd cterm=none ctermfg=black ctermbg=green
highlight DiffDelete cterm=none ctermfg=red ctermbg=red
highlight DiffChange cterm=none ctermfg=black ctermbg=blue
highlight DiffText cterm=none ctermfg=black ctermbg=darkblue
highlight CocErrorFloat cterm=none ctermfg=black
highlight CocWarningFloat cterm=none ctermfg=yellow
highlight Visual ctermfg=black ctermbg=blue
