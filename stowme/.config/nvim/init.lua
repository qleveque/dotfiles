-- Vimrc
vim.cmd('source ~/.vimrc')

-- Scrollbar
require('scrollbar').setup{}

if vim.api.nvim_win_get_option(0, "diff") then
  return
end

-- Bufferline
local tab_bar_shortcuts = { BufferPrevious='h', BufferNext='l', BufferClose='j' , enew='k'}
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
  auto_hide=1
}

-- Tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local tree_api=require('nvim-tree.api')
local function node_path() return tree_api.tree.get_node_under_cursor().absolute_path end
local function tree_run() vim.cmd('sil !tmux splitw "run '..node_path()..'"') end
local function tree_open() vim.cmd('sil !o "'..node_path()..'"') end
local function tree_attach(bufnr)
  local arr={
    ['A']=tree_api.fs.rename,
    ['cw']=tree_api.fs.rename_sub,
    ['yW']=tree_api.fs.copy.absolute_path,
    ['yw']=tree_api.fs.copy.filename,
    ['yy']=tree_api.fs.copy.node,
    ['dd']=tree_api.fs.remove,
    ['xx']=tree_api.fs.cut,
    ['T']=tree_api.fs.create,
    ['p']=tree_api.fs.paste,
    ['l']=tree_api.node.open.edit,
    ['h']=tree_api.node.navigate.parent_close,
    ['é']=tree_run,
    ['<CR>']=tree_open,
  }
  for k, v in pairs(arr) do
    vim.keymap.set('n',k,v,{buffer=bufnr,silent=true,nowait=true})
  end
end
require('nvim-tree').setup{
  update_focused_file = { enable = true },
  view={ signcolumn='no' },
  renderer={ group_empty=true, root_folder_label=false },
  on_attach=tree_attach
}
vim.cmd('au VimEnter,BufEnter,BufRead *NvimTree* setlocal statusline=_')

-- Telescope
local telescope_actions=require("telescope.actions")
require('telescope').setup{defaults={mappings={i={
  ['<C-v>']={'<C-R>+',type='command'},
  ['<C-p>']=telescope_actions.cycle_history_prev,
  ['<C-n>']=telescope_actions.cycle_history_next,
  ['<Esc>']=telescope_actions.close,
  ['<Tab>']=telescope_actions.move_selection_previous,
  ['<S-Tab>']=telescope_actions.move_selection_next,
}}}}
