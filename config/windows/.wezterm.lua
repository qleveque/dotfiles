local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.color_scheme = 'Catppuccin Mocha'
config.enable_scroll_bar = false
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.keys = {
  {key="Tab", mods="CTRL", action=wezterm.action{SendString="\x1b[27;5;9~"}},
  {key="Tab", mods="CTRL|SHIFT", action=wezterm.action{SendString="\x1b[27;6;9~"}},
}
config.font_size = 11
config.window_close_confirmation = 'NeverPrompt'

config.wsl_domains = {
  {
    name = 'WSL:Ubuntu',
    distribution = 'Ubuntu',
  }
}
config.default_domain = 'WSL:Ubuntu'

return config
