" Apply colors
if !has('win32')
  for [bg, contexts] in items({
    \"BG": ["ActiveWin","FloatermBorder","TelescopeNormal"],
    \"LIGHT_BG": ["CursorLine","InactiveWin","VertSplit"],
    \"LIGHTER_BG": ["CursorLineNr","DiffChange","Normal","PmenuSel","LineNr",
    \               "BufferTabpageFill","TelescopeSelection"],
    \"LIGHTEST_BG": ["DiffAdd","DiffDelete","DiffText","Pmenu","User1"]
    \})
    for context in contexts
      exe 'hi '.context.' gui=none guifg=none guibg='.eval('$'.bg)
    endfor
  endfor
  for v in ["","Mod","Index","Sign"]
    exe 'hi BufferCurrent'.v.' guibg='.eval('$BG')
    for k in ["Inactive","Visible"]
      exe 'hi Buffer'.k.v.' guibg='.eval('$LIGHTEST_BG')
    endfor
  endfor
  exe 'hi Visual guifg=black guibg='.eval('$GREY')
  exe 'hi StatusLine gui=underline guibg='.eval('$BG')
  exe 'hi StatusLineNC gui=underline guibg='.eval('$LIGHT_BG')

  au FocusLost * setlocal winhl=Normal:InactiveWin
  au BufNew,BufLeave,BufRead,FocusGained * setlocal
    \ winhl=Normal:ActiveWin,NormalNC:InactiveWin
endif
