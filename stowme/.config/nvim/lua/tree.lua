vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function run()
  local api=require'nvim-tree.api'
  local node=api.tree.get_node_under_cursor()
  vim.cmd('sil !tmux splitw "run '..node.absolute_path..'"')
end

local function open()
  local api=require'nvim-tree.api'
  local node=api.tree.get_node_under_cursor()
  vim.cmd('sil !o "'..node.absolute_path..'"')
end

local function tree(bufnr)
  local api=require'nvim-tree.api'
  local arr={
    ['A']=api.fs.rename,
    ['cw']=api.fs.rename_sub,
    ['yW']=api.fs.copy.absolute_path,
    ['yw']=api.fs.copy.filename,
    ['yy']=api.fs.copy.node,
    ['dd']=api.fs.remove,
    ['xx']=api.fs.cut,
    ['T']=api.fs.create,
    ['p']=api.fs.paste,
    ['l']=api.node.open.edit,
    ['h']=api.node.navigate.parent_close,
    ['é']=run,
    ['<CR>']=open,
  }
  for k, v in pairs(arr) do
    vim.keymap.set('n',k,v,{buffer=bufnr,silent=true,nowait=true})
  end
end

vim.api.nvim_exec([[
  au VimEnter,BufEnter,BufRead *NvimTree* setlocal statusline=_
]], false)

require'nvim-tree'.setup{
  update_focused_file = {
    enable = true
  },
  view={
    signcolumn='no'
  },
  renderer={
    group_empty=true,
    root_folder_label=false
  },
  on_attach=tree
}
