-- Download lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use cb for the clipboard
vim.g.clipboard = {
  copy = { ['+'] = 'cb copy' },
  paste = { ['+'] = 'cb paste' },
  cache_enabled = 0
}

-- Specific configs
local diff = os.getenv("NVIM_DIFF");
if diff then
  vim.cmd[[
    set ls=0 nonu stal=0
    au VimEnter,BufEnter,BufRead diffview://* setlocal statusline=_
    nnoremap = ]c
    nnoremap + [c
  ]]
end

-- Git
local function GitWrap()
  print("GitWrap")
  local c = vim.fn.nr2char(vim.fn.getchar())
  if c == "b" then
    vim.cmd("BlameToggle")
  else
    local file = vim.fn.expand("%")
    local line = vim.fn.line(".")
    local cmd = "silent !git-wrap " .. c .. " -f" .. file .. " -l" .. line
    print(cmd)
    vim.cmd(cmd)
  end
end
vim.keymap.set("n", "<C-g>", GitWrap, { silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.api.nvim_set_hl(0, "CommitTooLong", { bg = "#ff0000" })
    vim.w.first_line_cc = vim.fn.matchadd("CommitTooLong", [[\%1l\%>50v.\+]])
    vim.opt_local.textwidth = 72
  end,
})

-- Tree sitter
vim.treesitter.language.register('bash', 'zsh')
vim.treesitter.language.register('javascript', 'babel')
vim.treesitter.language.register('xml', 'ant')
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

local plugin_modules = require("user")
local nvim_plugins = plugin_modules.all(diff)

for _, plugin in ipairs(require("user.lsp").plugins(diff)) do
  table.insert(nvim_plugins, plugin)
end

for _, plugin in ipairs(plugin_modules.copilot_plugins()) do
  table.insert(nvim_plugins, plugin)
end

-- Load lazy
local disabled={'gzip','netrwPlugin','rplugin','shada','spellfile','tarPlugin','tohtml','tutor','zipPlugin','matchit'}
require("lazy").setup(nvim_plugins, { performance = { rtp = { disabled_plugins = disabled}}})
