-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "christoomey/vim-tmux-navigator",
  "farmergreg/vim-lastplace",
  "mattn/emmet-vim",
  "michaeljsmith/vim-indent-object",
  "pocco81/auto-save.nvim",
  "roxma/vim-paste-easy",
  "sheerun/vim-polyglot",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "wellle/targets.vim",
  {"neoclide/coc.nvim", branch = "release"},
  {"ggandor/leap.nvim", lazy=true},
  {"numToStr/Comment.nvim", opts= {}},
  {"petertriho/nvim-scrollbar", opts={}},
  {"windwp/nvim-autopairs", lazy=true, event = "InsertEnter", opts = {}},
  {
    "SUSTech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      keymaps = {
          init_selection = "_",
          node_incremental = "_",
          node_decremental = "-",
      },
    }
  },
  {
    "romgrk/barbar.nvim",
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    init = function() vim.g.barbar_auto_setup = false end,
    enabled = not vim.api.nvim_win_get_option(0, "diff"),
    opts = {
      exclude_ft={'qf'},
      sidebar_filetypes={
        NvimTree={ text=' '..vim.fn.fnamemodify(vim.fn.getcwd(), ":t")..'/' }
      },
      auto_hide=1,
    }
  },
  {
    "stevearc/aerial.nvim",
    lazy=true,
    cmd="AerialOpen",
    opts={
      autojump = true,
      backends = { "treesitter" },
      close_on_select = true,
      keymaps = { ["<C-j>"] = false, ["<C-k>"] = false },
      layout = { width = 30 },
      resize_to_content = false,
      lazy_load = true,
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
      },
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy=true,
    cmd= "NvimTreeFindFile",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
    local tree_api=require('nvim-tree.api')
    local function node_path() return tree_api.tree.get_node_under_cursor().absolute_path end
    local function tree_attach(bufnr)
      local arr={
        ['A']=tree_api.fs.rename,
        ['cw']=tree_api.fs.rename_sub,
        ['yW']=tree_api.fs.copy.absolute_path,
        ['yw']=tree_api.fs.copy.relative_path,
        ['yy']=tree_api.fs.copy.node,
        ['dd']=tree_api.fs.remove,
        ['xx']=tree_api.fs.cut,
        ['T']=tree_api.fs.create,
        ['p']=tree_api.fs.paste,
        ['l']=tree_api.node.open.edit,
        ['h']=tree_api.node.navigate.parent_close,
        ['L']=tree_api.tree.change_root_to_node,
        ['H']=tree_api.tree.change_root_to_parent,
        ['é']=function() vim.cmd('sil !tmux splitw "run \\"'..node_path()..'\\""') end,
        ['<CR>']=function() vim.cmd('sil !o "'..node_path()..'"') end,
        ['<C-f>']=function() vim.cmd('wincmd p') end,
      }
      for k, v in pairs(arr) do
        vim.keymap.set('n',k,v,{buffer=bufnr,silent=true,nowait=true})
      end
    end
    require('nvim-tree').setup{
      update_focused_file = { enable = true },
      view={ signcolumn='no' },
      renderer={ group_empty=true, root_folder_label=false },
      on_attach=tree_attach,
      actions = {open_file = { window_picker = { enable = false } } },
    }
    vim.cmd('au VimEnter,BufEnter,BufRead *NvimTree* setlocal statusline=_')
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy=true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config=function()
      local telescope_actions=require("telescope.actions")
      require('telescope').setup{defaults={
        mappings={i={
          ['<C-v>']={'<C-R>+',type='command'},
          ['<C-p>']=telescope_actions.cycle_history_prev,
          ['<C-n>']=telescope_actions.cycle_history_next,
          ['<Esc>']=telescope_actions.close,
          ['<S-Tab>']=telescope_actions.move_selection_previous,
          ['<Tab>']=telescope_actions.move_selection_next,
        }},
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
      }}
      end
  },
})

-- Vimrc
vim.cmd('source ~/.vimrc')
