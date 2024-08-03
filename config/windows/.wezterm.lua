local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- Parameters
config.color_scheme = 'Catppuccin Mocha'
config.enable_scroll_bar = false
config.window_decorations = "RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }
config.leader = {key = 'b', mods = 'CTRL',}
config.font_size = 10
config.window_close_confirmation = 'NeverPrompt'
config.wsl_domains = { { name = 'WSL:Ubuntu', distribution = 'Ubuntu' } }
config.default_domain = 'WSL:Ubuntu'
config.audible_bell = 'Disabled'

-- Keybindings
config.keys = {
  { key='Tab', mods = 'CTRL', action=wezterm.action{SendString='\x1b[27;5;9~'}},
  { key='Tab', mods = 'CTRL|SHIFT', action=wezterm.action{SendString='\x1b[27;6;9~'}},
  { key = ';', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = ',', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  { key = 's', mods = 'LEADER', action = act.SplitVertical{} },
  { key = 'v', mods = 'LEADER', action = act.SplitHorizontal{}},
  { key = 'n', mods = 'LEADER', action = act { SpawnTab = 'CurrentPaneDomain' },},
  { key = 'l', mods = 'LEADER', action = wezterm.action.SendString('\x0c')},
  { key = 'q', mods = 'LEADER', action=act{CloseCurrentPane={confirm=false}}},
}

-- Smart splits
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
smart_splits.apply_to_config(config, {
  direction_keys = { 'h', 'j', 'k', 'l' },
  modifiers = { move = 'CTRL', },
})

-- Copy mode
local copy_mode = true
if copy_mode then
  -- Custom actions
  function delayed_actions(actions)
    return wezterm.action_callback(
      function(w, p) for _, a in ipairs(actions) do w:perform_action(a, p) end end
    )
  end
  local act_search_empty = act.Multiple({act.CopyMode"ClearPattern", act{Search={CaseInSensitiveString=""}},})
  local act_clear_selection = act.Multiple({
    act.ClearSelection,
    act.CopyMode('ClearSelectionMode'),
  })
  local act_select = wezterm.action_callback(
    function(w, p)
      local selection_mode = 'Cell'
      if w:get_selection_text_for_pane(p) ~= "" then selection_mode = 'Line' end
      w:perform_action(act.CopyMode { SetSelectionMode = selection_mode }, p)
    end
  )

  -- Shortcuts
  local to_custom_mode = {
    { key = 'a', mods = 'CTRL',
      action = delayed_actions({
        act_clear_selection,
        act.ActivateCopyMode,
        act.CopyMode("ClearPattern"),
        act.CopyMode('MoveUp'), act.CopyMode('MoveUp'), act.CopyMode('MoveUp'),
        act.CopyMode("MoveToStartOfLine"),
      })
    },
    { key = 's', mods = 'CTRL', action=delayed_actions({act.ActivateCopyMode, act_search_empty}) },
  }

  local custom_copy_mode = {
    {key="Enter", mods="NONE",
      action=delayed_actions({
        act.CopyMode("AcceptPattern"),
        act.CopyMode('Close'),
      })
    },
    { key="v", mods="NONE", action=act_select },
    {key="Escape", mods="NONE", action=act_clear_selection},
    {key="N", mods="NONE", action=act{CopyMode="NextMatch"} },
    {key="n", mods="NONE", action=act{CopyMode="PriorMatch"} },
    {key="?", mods="SHIFT", action=act_search_empty},
    { key = 'y', mods = 'NONE',
      action = act.Multiple({
        act.CopyTo 'PrimarySelection',
        act_clear_selection
      }),
    },
  }

  local custom_search_mode = {
    { key="Enter", mods="NONE", action = act.ActivateCopyMode },
    { key="c", mods="CTRL", action="ActivateCopyMode"},
    { key="r", mods="CTRL", action=act.CopyMode("CycleMatchType")},
  }

  -- Setup
  for _, action in ipairs(to_custom_mode) do table.insert(config.keys, action) end
  local copy_mode = wezterm.gui.default_key_tables().copy_mode
  for _, action in ipairs(custom_copy_mode) do table.insert(copy_mode, action) end
  local search_mode = wezterm.gui.default_key_tables().search_mode
  for _, action in ipairs(custom_search_mode) do table.insert(search_mode, action) end
  config.key_tables = { copy_mode = copy_mode, search_mode = search_mode }
end

return config
