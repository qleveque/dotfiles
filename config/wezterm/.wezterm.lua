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
  {mods='CTRL', key='Tab', action=a.SendKey{key='F5'}},
  {mods='CTRL|SHIFT', key='Tab', action=a.SendKey{key='F6'}},
  {mods='CTRL', key='Enter', action=a.SendKey{key='F9'}},
  {mods='CTRL|SHIFT', key='Enter',action=a.SendKey{key='F10'}},
  {mods='CTRL', key='Space', action=a.SendKey{key='F4'}},
  {mods='CTRL', key='Backspace', action=a.SendKey{key='F3'}},
  {mods='CTRL', key=',', action=a.SendKey{key='F7'}},
  {mods='CTRL', key=';', action=a.SendKey{key='F8'}},
}
if wez.target_triple:match("windows") then
  c.default_prog = { 'wsl.exe', 'zellij' }
end

return c
