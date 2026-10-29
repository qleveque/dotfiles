local M = {}

function M.plugins(_diff)
  return {
    "tpope/vim-repeat",
    "tpope/vim-sleuth",
    { "numToStr/Comment.nvim", opts = {} },
    {
      "kylechui/nvim-surround",
      config = function()
        vim.keymap.set("n", "s", "<Plug>(nvim-surround-normal)")
        vim.keymap.set("n", "ss", "<Plug>(nvim-surround-normal-cur)")
        vim.keymap.set("x", "s", "<Plug>(nvim-surround-visual)")
        vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)")
        vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)")
      end,
      version = "*",
      event = "VeryLazy",
    },
    "machakann/vim-highlightedyank",
    "farmergreg/vim-lastplace",
    "wellle/targets.vim",
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = { map_cr = true } },
    { "echasnovski/mini.splitjoin", opts = { mappings = { toggle = 'S' } } },
    {
      "mattn/emmet-vim",
      keys = { { '<C-e>', '<C-y>,', mode = { 'v', 'i' }, remap = true } },
    },
    {
      "SUSTech-data/wildfire.nvim",
      event = "VeryLazy",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      opts = {
        surrounds = {},
        keymaps = {
          init_selection = '-',
          node_incremental = '-',
          node_decremental = '_',
        },
      },
    },
  }
end

return M
