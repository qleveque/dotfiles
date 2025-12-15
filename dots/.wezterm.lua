local wez=require 'wezterm'
local a=wez.action

-- Workarounds
wez.on('user-var-changed', function(w, p, name, value)
  if name == 'MOVE_TAB' then w:perform_action(wez.action.MoveTab(tonumber(value)), p) end
end)
local function has_nvidia_driver()
    for _, obj in ipairs(wez.gui.enumerate_gpus()) do if obj.driver == "NVIDIA" then return true end end
    return false
end

local c=wez.config_builder()
c.audible_bell='Disabled'
if has_nvidia_driver() then
  c.front_end='Software'
else
  c.front_end='WebGpu'
  c.webgpu_power_preference = 'HighPerformance'
end

c.color_scheme='Catppuccin Mocha'
c.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.5,
}
c.warn_about_missing_glyphs=false
c.enable_scroll_bar=false
c.initial_cols=100
c.initial_rows=40
c.font_size=9.3
c.leader={key='b', mods='CTRL'}
c.window_padding={left=0, right=0, top=0, bottom=0}
c.adjust_window_size_when_changing_font_size=false
c.keys={
  {key='F11', action=a.ToggleFullScreen},
  {key='Tab', mods='CTRL', action=a{SendString='\x1b[27;5;9~'}},
  {key='Enter', mods='CTRL', action=a{SendString='\x1b[13;5u'}},
  {key='Enter',mods='CTRL|SHIFT',action=a.SendKey{key='F13'}},
  {key='Tab', mods='CTRL|SHIFT', action=a{SendString='\x1b[27;6;9~'}},
  {key='Space', mods= 'SHIFT', action=a{SendString='\x1b[27;2;32~'}},
  {key=';', mods='CTRL', action=a.ActivateTabRelative(1)},
  {key=',', mods='CTRL', action=a.ActivateTabRelative(-1)},
  {key='s', mods='LEADER', action=a.SplitVertical{}},
  {key='v', mods='LEADER', action=a.SplitHorizontal{}},
  {key='n', mods='LEADER', action=a{SpawnTab='CurrentPaneDomain'}},
  {key='q', mods='LEADER', action=a{CloseCurrentPane={confirm=false}}},
  {key='f', mods='LEADER', action=a.TogglePaneZoomState},
  {key='l', mods='LEADER', action=a.Multiple{a.ClearScrollback'ScrollbackAndViewport',a.SendString'\x0c'}},
  {key='a', mods='LEADER', action=wez.action_callback(function(w,p)
      wez.run_child_process({ 'bash', '-c', '~/dotfiles/bin/wez_wrap copy '..p:pane_id() })
  end)},
  {key='r', mods='LEADER', action=a.PromptInputLine{action=wez.action_callback(
    function(w, p, t) w:active_tab():set_title(t) end
  )}},
}
c.window_background_opacity = 0.93
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
