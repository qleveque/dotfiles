for [bg, contexts] in items({
  \"BG":["ActiveWin","FloatermBorder","TelescopeNormal"],
  \"LIGHT_BG":["CursorLine","InactiveWin","VertSplit"],
  \"LIGHTER_BG":["CursorLineNr","PmenuSel","LineNr","BufferTabpageFill","TelescopeSelection"],
  \"LIGHTEST_BG":["Pmenu","User1"],
  \"RED":["ConflictMarkers"],"GREEN":["DiffAdd"],"BLUE":["DiffText","CurSearch"]})
  for context in contexts
    exe 'hi '.context.' gui=none guifg=none guibg='.eval('$'.bg)
  endfor
endfor
for v in ['','Mod','Index','Sign']
  exe 'hi BufferCurrent'.v.' guibg='.eval('$BG')
  exe 'hi BufferInactive'.v.' guibg='.eval('$LIGHTEST_BG')
  exe 'hi BufferVisible'.v.' guibg='.eval('$LIGHTEST_BG')
endfor
exe 'hi Visual guifg=black guibg='.eval('$GREY')
exe 'hi StatusLine gui=underline guibg='.eval('$BG')
exe 'hi StatusLineNC gui=underline guibg='.eval('$LIGHT_BG')
exe 'hi DiffDelete guibg='.eval('$RED').' guifg='.eval('$RED')
hi CocErrorFloat guifg=orange
hi DiffChange guibg=none
au FocusLost * setlocal winhl=Normal:InactiveWin
au BufEnter,BufRead,BufReadPost * syntax match ConflictMarkers "\v\<{7}.*([\r\n]+[^\>].*$)*[\r\n]+.*"
au BufNew,BufLeave,BufRead,FocusGained * setlocal winhl=Normal:ActiveWin,NormalNC:InactiveWin
