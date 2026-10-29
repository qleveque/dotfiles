local M = {}

function M.plugins()
  vim.g.copilot_no_tab_map = true
  -- <F10> is <C-S-CR>
  vim.keymap.set('n', '<F10>', '<cmd>CopilotChatToggle<CR>', { noremap = true, silent = true })
  vim.keymap.set('v', '<F10>', '<cmd>CopilotChatToggle<CR>', { noremap = true, silent = true })
  -- <F9> is <C-CR>
  vim.api.nvim_set_keymap("i", "<F9>", 'copilot#Accept("")', { expr = true, silent = true })

  return {
    {
      "github/copilot.vim",
      {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
          { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
          mappings = {
            reset = false,
            ["<C-l>"] = false,
          },
        },
      },
    },
  }
end

return M
