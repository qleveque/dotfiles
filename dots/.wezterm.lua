local wez=require 'wezterm'
local a=wez.action
wez.on('user-var-changed', function(w, p, name, value)
  if name == 'MOVE_TAB' then w:perform_action(wez.action.MoveTab(tonumber(value)), p) end
end)
function run_new(title, command) return wez.action_callback(function(w,p)
  wez.run_child_process({ 'bash', '-c', '~/dotfiles/bin/wez new "'..title..'" "'..command(w,p)..'"' })
end) end
function set_title(w, p, t) w:active_tab():set_title(t) end

local c=wez.config_builder()
c.audible_bell='Disabled'
c.color_scheme='Catppuccin Mocha'
c.enable_scroll_bar=false
c.font_size=9.3
c.leader={key='b', mods='CTRL'}
c.window_padding={left=0, right=0, top=0, bottom=0}
c.adjust_window_size_when_changing_font_size=false
c.keys={
  {key="F11", action=a.ToggleFullScreen},
  {key='Tab', mods='CTRL', action=a{SendString='\x1b[27;5;9~'}},
  {key='Tab', mods='CTRL|SHIFT', action=a{SendString='\x1b[27;6;9~'}},
  {key='Space', mods= 'SHIFT', action=a{SendString='\x1b[27;2;32~'}},
  {key=';', mods='CTRL', action=a.ActivateTabRelative(1)},
  {key=',', mods='CTRL', action=a.ActivateTabRelative(-1)},
  {key='s', mods='LEADER', action=a.SplitVertical{}},
  {key='v', mods='LEADER', action=a.SplitHorizontal{}},
  {key='n', mods='LEADER', action=a{SpawnTab='CurrentPaneDomain'}},
  {key='q', mods='LEADER', action=a{CloseCurrentPane={confirm=false}}},
  {key='f', mods='LEADER', action=a.TogglePaneZoomState},
  {key='d', mods='LEADER', action=run_new('draft', function(w,p) return 'nvim ~/.draft.txt' end)},
  {key='a', mods='LEADER', action=run_new('copy-mode', function(w,p) return 'wez copy-pane '..p:pane_id() end)},
  {key='l', mods='LEADER', action=a.Multiple{a.ClearScrollback'ScrollbackAndViewport',a.SendString'\x0c'}},
  {key='r', mods='LEADER', action=a.PromptInputLine{action=wez.action_callback(set_title)}},
}
if wez.target_triple:match("windows") then
  c.wsl_domains={{name='WSL:Ubuntu', distribution='Ubuntu-24.04'}}
  c.default_domain='WSL:Ubuntu'
end

local smarts=wez.plugin.require('http://github.com/mrjones2014/smart-splits.nvim')
smarts.apply_to_config(c,{direction_keys={'h','j','k','l'},modifiers={move='CTRL'}})
local tabline=wez.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local tabline_tab={{'tab', padding=1, icons_enabled=false}, { 'zoomed', padding=0 }}
tabline.setup({sections={
  tabline_a={}, tabline_b={}, tabline_c={}, tabline_x={}, tabline_y={},
  tabline_z={'hostname'}, tab_active=tabline_tab, tab_inactive=tabline_tab,
}})
tabline.apply_to_config(c)
return c
