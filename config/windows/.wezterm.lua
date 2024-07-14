local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- config.enable_scroll_bar = false
-- config.enable_tab_bar = false

config.color_scheme = 'Catppuccin Mocha'
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.leader = {
  key = 'b',
  mods = 'CTRL',
}

config.keys = {
  {key="Tab", mods="CTRL", action=wezterm.action{SendString="\x1b[27;5;9~"}},
  {key="Tab", mods="CTRL|SHIFT", action=wezterm.action{SendString="\x1b[27;6;9~"}},
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain'},
  },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain'},
  },
  {
    key = "n",
    mods = "LEADER",
    action = wezterm.action { SpawnTab = "CurrentPaneDomain" },
  },
  {
    key = 'j',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'h',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key ='a',
    mods = 'CTRL',
    action = wezterm.action.ActivateCopyMode,
  },
  {
    key="q",
    mods="LEADER",
    action=wezterm.action{CloseCurrentPane={confirm=false}}
  },
}

config.font_size = 11
config.window_close_confirmation = 'NeverPrompt'
config.default_prog = { 'zsh' }


return config
