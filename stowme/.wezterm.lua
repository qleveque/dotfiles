local wezterm = require 'wezterm'
local c = wezterm.config_builder()
local act = wezterm.action

-- Parameters
c.audible_bell = 'Disabled'
c.color_scheme = 'Catppuccin Mocha'
c.enable_scroll_bar = false
c.font_size = 10
c.leader = {key = 'b', mods = 'CTRL'}
c.window_decorations = "RESIZE"
c.window_padding = {left = 0, right = 0, top = 0, bottom = 0}
c.keys = {
  {key='Tab', mods = 'CTRL', action=act{SendString='\x1b[27;5;9~'}},
  {key='Tab', mods = 'CTRL|SHIFT', action=act{SendString='\x1b[27;6;9~'}},
  {key = ';', mods = 'CTRL', action = act.ActivateTabRelative(1)},
  {key = ',', mods = 'CTRL', action = act.ActivateTabRelative(-1)},
  {key = 's', mods = 'LEADER', action = act.SplitVertical{}},
  {key = 'v', mods = 'LEADER', action = act.SplitHorizontal{}},
  {key = 'n', mods = 'LEADER', action = act{SpawnTab='CurrentPaneDomain'}},
  {key = 'q', mods = 'LEADER', action=act{CloseCurrentPane={confirm=false}}},
  {
    key = 'l', mods = 'LEADER',
    action=act.Multiple{act.ClearScrollback'ScrollbackAndViewport',act.SendString'\x0c'}
  },
  {
    key = 'a', mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(w, p) w:perform_action(
      act.SpawnCommandInNewTab{args={'zsh','-c','copymode '..p:pane_id()..' 0 -c "norm G"'}},p
    )end),
  },
}

if wezterm.target_triple:match("windows") then
  c.wsl_domains = {{name = 'WSL:Ubuntu', distribution = 'Ubuntu'}}
  c.default_domain = 'WSL:Ubuntu'
end

-- Smart splits
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
smart_splits.apply_to_config(c,{direction_keys={'h','j','k','l'},modifiers={move='CTRL'}})

return c
