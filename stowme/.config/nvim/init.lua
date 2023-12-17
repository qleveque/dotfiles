-- Vimrc
vim.cmd('source ~/.vimrc')

-- Comments
require('Comment').setup()

-- Leap
local function leap() require('leap').leap { target_windows = { vim.fn.win_getid() } } end
vim.keymap.set('n', '<Space>', leap)
vim.keymap.set('v', '<Space>', leap)

-- TreeSitter
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}

require("wildfire").setup{
    keymaps = {
        init_selection = "_",
        node_incremental = "_",
        node_decremental = "-",
    },
}

-- Scrollbar
require('scrollbar').setup{}

-- Telescope
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

-- Bufferline
if vim.api.nvim_win_get_option(0, "diff") then
  return
end

local tab_bar_shortcuts = { BufferPrevious='h', BufferNext='l', BufferClose='j' , BufferRestore='k'}
for _, mode in ipairs({'n', 'i'}) do
  for action, shortcut in pairs (tab_bar_shortcuts) do
    vim.keymap.set(mode,'<M-'..shortcut..'>','<Cmd>'..action..'<CR>',{})
  end
end
require('bufferline').setup{
  exclude_ft={'qf'},
  sidebar_filetypes={
    NvimTree={ text=' '..vim.fn.fnamemodify(vim.fn.getcwd(), ":t")..'/' }
  },
  auto_hide=1,
}

-- Symbol tree
require("aerial").setup({
  autojump = true,
  backends = { "treesitter" },
  close_on_select = true,
  keymaps = { ["<C-j>"] = false, ["<C-k>"] = false },
  layout = { width = 30 },
  resize_to_content = false,
})

-- Tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
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
    ['é']=function() vim.cmd('sil !tmux splitw "run '..node_path()..'"') end,
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
