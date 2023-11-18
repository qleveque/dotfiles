let RED="IndianRed4"
let GREEN="DarkGreen"
let BLUE="SlateBlue"

for [bg, contexts] in items({
    \"$PALETTE_1":["ActiveWin","TelescopeNormal","StatusLine"],
    \"$PALETTE_2":["CursorLine","InactiveWin","VertSplit","StatusLineNC"],
    \"$PALETTE_3":["CursorLineNr","LineNr","BufferTabpageFill","TelescopeSelection",
    \    "User1","NvimTreeCursorLine","CocMenuSel","PmenuSel"],
    \"$PALETTE_4":["Visual","Pmenu","CocFloating","CurSearch", "AerialLine",
    \    "CocErrorSign","CocWarningSign","CocInfoSign","CocHintSign"],
    \"RED":["ConflictMarkers"],"GREEN":["DiffAdd"],"BLUE":["DiffText"]})
  for context in contexts
    exe 'hi '.context.' gui=none guifg=none guibg='.eval(bg)
  endfor
endfor

for v in ['','Mod','Index','Sign']
  exe 'hi BufferCurrent'.v.' guibg='.eval('$PALETTE_1')
  exe 'hi BufferInactive'.v.' guibg='.eval('$PALETTE_3')
  exe 'hi BufferVisible'.v.' guibg='.eval('$PALETTE_3')
endfor

exe 'hi User guifg='.eval('$PALETTE_2')
exe 'hi DiffDelete guibg='.eval('RED').' guifg='.eval('RED')

hi Visual guifg=white
hi StatusLine gui=underline
hi StatusLineNC gui=underline
hi CocErrorFloat guifg=orange
hi DiffChange guibg=none

au FocusLost * setlocal winhl=Normal:InactiveWin
au BufEnter,BufRead,BufReadPost * syntax match ConflictMarkers "\v[\<\>\|=]{7}.*"
au BufNew,BufLeave,BufRead,FocusGained * setlocal winhl+=Normal:ActiveWin,NormalNC:InactiveWin
