set bg=dark
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

highlight CocFloating ctermbg=darkgray

highlight CocErrorFloat ctermfg=lightred
highlight CocWarningFloat ctermfg=yellow
highlight CocHintFloat ctermfg=white
highlight CocInfoFloat ctermfg=lightblue

highlight CocErrorSign ctermbg=red
highlight CocWarningSign ctermbg=yellow
highlight CocHintSign ctermbg=blue
highlight CocInfoSign ctermbg=cyan

highlight CocErrorHighlight cterm=bold,underline
highlight CocWarningHighlight cterm=bold,underline
highlight CocHintHighlight cterm=bold,underline
highlight CocInfoHighlight cterm=bold,underline
