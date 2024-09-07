-- Variables
local wezterm = require 'wezterm'
local c = wezterm.config_builder()
local act = wezterm.action
local clear_screen=act.Multiple{act.ClearScrollback'ScrollbackAndViewport',act.SendString'\x0c'} 
local set_tab_title=act.PromptInputLine {
  action=wezterm.action_callback(function(w, p, line) w:active_tab():set_title(line) end),
}
local copy_mode=wezterm.action_callback(function(w, p)
  local copy=act.SpawnCommandInNewTab{args={'zsh','-c','wez copy-pane '..p:pane_id()..'&&wez _prev'}}
  w:perform_action(act.Multiple{copy, move_tab_next(w)}, p)
end)
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')

-- Hacks to spawn tab next to current one
wezterm.on('user-var-changed', function(w, p, name, value)
  if name == 'MOVE_TAB' then w:perform_action(act.MoveTab(tonumber(value)), p) end
end)
function move_tab_next(w) for _, item in ipairs(w:mux_window():tabs_with_info()) do
    if item.is_active then return act.MoveTab(item.index + 1) end
end end

-- Configuration
c.audible_bell = 'Disabled'
c.color_scheme = 'Catppuccin Mocha'
c.enable_scroll_bar = false
c.font_size = 10
c.leader = {key = 'b', mods = 'CTRL'}
c.window_decorations = 'RESIZE'
c.window_padding = {left = 0, right = 0, top = 0, bottom = 0}
c.keys = {
  {key = 'Tab', mods = 'CTRL', action = act{SendString='\x1b[27;5;9~'}},
  {key = 'Tab', mods = 'CTRL|SHIFT', action = act{SendString='\x1b[27;6;9~'}},
  {key = 'Space', mods= 'SHIFT', action = act{SendString='\x1b[27;2;32~'}},
  {key = ';', mods = 'CTRL', action = act.ActivateTabRelative(1)},
  {key = ',', mods = 'CTRL', action = act.ActivateTabRelative(-1)},
  {key = 's', mods = 'LEADER', action = act.SplitVertical{}},
  {key = 'v', mods = 'LEADER', action = act.SplitHorizontal{}},
  {key = 'n', mods = 'LEADER', action = act{SpawnTab='CurrentPaneDomain'}},
  {key = 'q', mods = 'LEADER', action = act{CloseCurrentPane={confirm=false}}},
  {key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState},
  {key = 'l', mods = 'LEADER', action = clear_screen},
  {key = 'r', mods = 'LEADER', action = set_tab_title},
  {key = 'a', mods = 'LEADER', action = copy_mode},
}
if wezterm.target_triple:match("windows") then
  c.wsl_domains = {{name = 'WSL:Ubuntu', distribution = 'Ubuntu-24.04'}}
  c.default_domain = 'WSL:Ubuntu'
end
smart_splits.apply_to_config(c,{direction_keys={'h','j','k','l'},modifiers={move='CTRL'}})
return c
