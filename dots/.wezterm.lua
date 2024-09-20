local wez = require 'wezterm'

-- Hacks to spawn tab next to current one
wez.on('user-var-changed', function(w, p, name, value)
  if name == 'MOVE_TAB' then w:perform_action(wez.action.MoveTab(tonumber(value)), p) end
end)
function move_tab_next(w) for _, item in ipairs(w:mux_window():tabs_with_info()) do
    if item.is_active then return wez.action.MoveTab(item.index + 1) end
end end

-- Configuration
local c = wez.config_builder()
c.audible_bell = 'Disabled'
c.color_scheme = 'Catppuccin Mocha'
c.enable_scroll_bar = false
c.font_size = 9.3
c.leader = {key = 'b', mods = 'CTRL'}
c.window_decorations = 'RESIZE'
c.window_padding = {left = 0, right = 0, top = 0, bottom = 0}
c.keys = {
  {key = 'Tab', mods = 'CTRL', action = wez.action{SendString='\x1b[27;5;9~'}},
  {key = 'Tab', mods = 'CTRL|SHIFT', action = wez.action{SendString='\x1b[27;6;9~'}},
  {key = 'Space', mods= 'SHIFT', action = wez.action{SendString='\x1b[27;2;32~'}},
  {key = ';', mods = 'CTRL', action = wez.action.ActivateTabRelative(1)},
  {key = ',', mods = 'CTRL', action = wez.action.ActivateTabRelative(-1)},
  {key = 's', mods = 'LEADER', action = wez.action.SplitVertical{}},
  {key = 'v', mods = 'LEADER', action = wez.action.SplitHorizontal{}},
  {key = 'n', mods = 'LEADER', action = wez.action{SpawnTab='CurrentPaneDomain'}},
  {key = 'q', mods = 'LEADER', action = wez.action{CloseCurrentPane={confirm=false}}},
  {key = 'z', mods = 'LEADER', action = wez.action.TogglePaneZoomState},
  {key = 'a', mods = 'LEADER', action = wez.action_callback(function(w, p)
    local copy=wez.action.SpawnCommandInNewTab{
      args={'zsh','-c','wez copy-pane '..p:pane_id()..'&&wez _prev'}
    }
    w:perform_action(wez.action.Multiple{copy, move_tab_next(w)}, p)
  end)},
  {key = 'l', mods = 'LEADER', action = wez.action.Multiple{
    wez.action.ClearScrollback'ScrollbackAndViewport', wez.action.SendString'\x0c'
  }},
  {key = 'r', mods = 'LEADER', action = wez.action.PromptInputLine {
    action=wez.action_callback(function(w, p, t) w:active_tab():set_title(t) end),
  }},
}
if wez.target_triple:match("windows") then
  c.wsl_domains = {{name = 'WSL:Ubuntu', distribution = 'Ubuntu-24.04'}}
  c.default_domain = 'WSL:Ubuntu'
end
local smarts=wez.plugin.require('http://github.com/mrjones2014/smart-splits.nvim')
smarts.apply_to_config(c,{direction_keys={'h','j','k','l'},modifiers={move='CTRL'}})

return c
