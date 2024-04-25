" vim: set ft=vim:
source ~/.theme.vim

set tgc stl=%1*\ \%f%m\ %0*%=

for [bg, contexts] in items({
    \PALETTE_1:['Active','TelescopeNormal','StatusLine','CocFloating'],
    \PALETTE_2:['CursorLine','Inactive','StatusLineNC','WinSeparator'],
    \PALETTE_3:['BufferTabpageFill','TelescopeSelection',
    \  'NvimTreeCursorLine','HighlightedyankRegion','AerialLine',
    \  'CocHighlightText','CocMenuSel','Pmenu'],
    \PALETTE_4:['User1','Visual','CurSearch']
    \})
  for context in contexts
    exe 'hi '.context.' gui=none guifg=none guibg='.bg
  endfor
endfor

exe 'hi LineNr guifg='.PALETTE_4

for v in ['','Mod','Index','Sign']
  exe 'hi BufferCurrent'.v.' guibg='.PALETTE_1
  exe 'hi BufferInactive'.v.' guibg='.PALETTE_3
  exe 'hi BufferVisible'.v.' guibg='.PALETTE_3
endfor

for [context, fg] in items({
    \'Error': 'IndianRed',
    \'Warning': 'orange',
    \'Info': 'LimeGreen',
    \'Hint': 'LightSkyBlue3'
    \})
  exe 'hi Coc'.context.'Sign guifg='.fg.' guibg='.PALETTE_3
  exe 'hi Coc'.context.'Float guifg='.fg
endfor

for v in ['User1', 'StatusLine', 'StatusLineNC', 'CocUnusedHighlight']
  exe 'hi '.v.' gui=underline'
endfor

hi DiffDelete guibg=IndianRed4 guifg=IndianRed4
hi DiffAdd gui=none guifg=none guibg=DarkGreen
hi DiffText gui=none guifg=none guibg=SlateBlue
hi DiffChange guibg=none

hi Cursor gui=reverse
hi Visual guifg=white

au FocusLost * set winhl=Normal:Inactive
au FocusGained,BufNew,BufLeave,BufRead * set winhl+=Normal:Active,NormalNC:Inactive
