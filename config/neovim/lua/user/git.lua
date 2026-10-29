local M = {}

function M.plugins(diff)
  return {
    {
      "FabijanZulj/blame.nvim",
      lazy = false,
      config = function()
        require('blame').setup {
          mappings = {
              stack_push = "H",
              stack_pop = "L",
              copy_hash = "yc",
          },
        }
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "blame",
          callback = function()
            vim.keymap.set("n", "l", function()
              vim.cmd("normal! ^yiw")
              vim.cmd("!git-wrap o")
            end, { buffer = true })
          end,
        })
      end,
      opts = {
        blame_options = { '-w' },
      },
    },
    {
      "sindrets/diffview.nvim",
      enabled = diff,
      init = function()
        local actions = require("diffview.actions")
        vim.api.nvim_create_autocmd("FocusGained", {
          callback = function()
            if vim.bo.filetype == "diffview" then
              vim.cmd("DiffviewRefresh")
            end
          end,
        })
        require('diffview').setup({
          enhanced_diff_hl = true,
          show_help_hints = false,
          option_mapping = false,
          hooks = {
            view_opened = function(view)
              vim.defer_fn(function()
                if view.class:name() == 'FileHistoryView' then
                  vim.keymap.set("n", "<c-f>", function() vim.api.nvim_input("<C-w>k<C-w>l") end, { buffer = true })
                else
                  vim.keymap.set("n", "<c-f>", function() vim.api.nvim_input("<C-w>l<C-w>l") end, { buffer = true })
                end
              end, 200)
            end,
          },
          keymaps = {
            view = {
              { "n", "<C-f>", actions.focus_files, { desc = "Bring focus to the file panel" } },
              { "n", "<C-q>", function() vim.cmd('qa!') end },
            },
            file_panel = {
              { "n", "<CR>", actions.select_entry },
              { "n", "l", actions.focus_entry },
              { "n", "<C-q>", function() vim.cmd('qa!') end },
              { "n", "C", function() vim.cmd('sil !zj-wrap split "git commit || read"') end },
              { "n", "A", function() vim.cmd('sil !zj-wrap split "git commit --amend || read"') end },
              { "n", "N", function() vim.cmd('sil !zj-wrap split "git commit --amend --no-edit || read"') end },
              { "n", "P", function() vim.cmd('sil !zj-wrap split "git push || read"') end },
            },
            file_history_panel = {
              { "n", "<CR>", actions.select_entry },
              { "n", "l", actions.focus_entry },
              { "n", "<C-q>", function() vim.cmd('qa!') end },
            },
            option_panel = {
              { "n", "<CR>", actions.close, { desc = "Close the panel" } },
            },
          },
        })
      end,
    },
  }
end

return M
