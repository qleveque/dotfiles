local wez=require 'wezterm'
local a=wez.action

local c=wez.config_builder()
c.audible_bell='Disabled'
c.color_scheme='Catppuccin Mocha'
c.warn_about_missing_glyphs=false
c.enable_scroll_bar=false
c.initial_cols=100
c.initial_rows=40
c.font_size=9.3
c.enable_tab_bar=false
c.window_decorations="RESIZE"
c.window_padding={left=0, right=0, top=0, bottom=0}
c.adjust_window_size_when_changing_font_size=false
c.keys={
  {key='Enter',mods='CTRL|SHIFT',action=a.SendKey{key='F13'}},
  {key='Enter', mods='CTRL', action=a.SendKey{key='F9'}},
  {key='Tab', mods='CTRL', action=a.SendKey{key='F15'}},
  {key='Tab', mods='CTRL|SHIFT', action=a.SendKey{key='F16'}},
  {key=',', mods='CTRL', action=a.SendKey{key='F7'}},
  {key=';', mods='CTRL', action=a.SendKey{key='F8'}},
  {key='Space', mods= 'SHIFT', action=a{SendString='\x1b[27;2;32~'}},
}
if wez.target_triple:match("windows") then
  c.default_prog = { 'wsl.exe', 'zellij' }
end


return c
