local M = {}

local function extend(dst, src)
  for _, item in ipairs(src) do
    table.insert(dst, item)
  end
end

function M.all(diff)
  local plugins = {}
  extend(plugins, require("user.ui").plugins(diff))
  extend(plugins, require("user.git").plugins(diff))
  extend(plugins, require("user.editing").plugins(diff))
  extend(plugins, require("user.navigation").plugins(diff))
  return plugins
end

function M.copilot_plugins()
  if not os.getenv("USE_GITHUB_COPILOT") then
    return {}
  end
  return require("user.copilot").plugins()
end

return M
