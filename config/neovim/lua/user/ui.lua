local M = {}

function M.plugins(diff)
  return {
    {
      "smart-splits-nvim/smart-splits.nvim",
      version = "^3.0.0",
      dependencies = {
        {
          "smart-splits-nvim/backend-zellij-lua",
          main = "smart-splits-backend-zellij-lua",
        },
      },
      opts = {
        mux = { backend = "smart-splits-backend-zellij-lua" },
      },
      init = function()
        vim.cmd[[
          nn <silent> <C-h> :SmartCursorMoveLeft<CR>
          nn <silent> <C-j> :SmartCursorMoveDown<CR>
          nn <silent> <C-k> :SmartCursorMoveUp<CR>
          nn <silent> <C-l> :SmartCursorMoveRight<CR>
        ]]
        local focused = true
        local function send_to_zellij(mode)
          vim.fn.jobstart({ "zellij", "action", "switch-mode", mode }, { detach = true })
        end
        vim.api.nvim_create_autocmd({"FocusGained", "VimEnter"}, {
            callback = function()
              focused = true
              vim.defer_fn(function()
                if focused then
                  send_to_zellij("locked")
                end
              end, 200)
            end
        })
        vim.api.nvim_create_autocmd({ "FocusLost", "VimLeavePre" }, {
          callback = function()
            focused = false
            send_to_zellij("normal")
          end,
        })
      end,
    },
    {
      "petertriho/nvim-scrollbar",
      branch = "refactor/v2",
      enabled = not diff,
      opts = { set_highlights = false },
    },
    { "echasnovski/mini.indentscope", opts = {} },
    {
      "echasnovski/mini.animate",
      config = function()
        require('mini.animate').setup({
          cursor = { timing = require('mini.animate').gen_timing.cubic({ duration = 150, unit = 'total' }) },
          scroll = { enable = false },
          open = { enable = false },
          resize = { enable = false },
          close = { enable = false },
        })
      end,
    },
    {
      "romgrk/barbar.nvim",
      dependencies = { 'kyazdani42/nvim-web-devicons' },
      enabled = not diff,
      init = function()
        vim.cmd[[
          map <F5> <Cmd>BufferNext<CR>
          map <F6> <Cmd>BufferPrevious<CR>
          nn Q <Cmd>BufferClose<CR>
          nn X <Cmd>BufferCloseAllButVisible<CR>
        ]]
        vim.g.barbar_auto_setup = false
      end,
      opts = {
        exclude_ft = { 'qf' },
        sidebar_filetypes = { NvimTree = { text = ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. '/' } },
        auto_hide = 1,
      },
    },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = false,
      priority = 1000,
      config = function()
        require'catppuccin'.setup {
          background = {
              light = "latte",
              dark = "mocha",
          },
          transparent_background = true,
          integrations = { nvimtree = false, barbar = true, coc_nvim = false, leap = true },
          custom_highlights = function(C)
            return {
              User1 = { fg = C.text, bg = C.surface1 },
              WinSeparator = { bg = C.mantle, fg = C.surface2 },
              StatusLine = { bg = "None", fg = C.surface2, underline = true },
              StatusLineNC = { bg = "None", fg = C.surface2, underline = true },
              ScrollbarHandle = { bg = C.surface1 },
              ScrollbarCursorHandle = { bg = C.surface1 },
            }
          end,
        }
        vim.cmd('colorscheme catppuccin')
      end,
    },
  }
end

return M
