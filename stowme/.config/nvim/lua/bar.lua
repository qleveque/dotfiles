vim.keymap.set('n','(','<Cmd>BufferPrevious<CR>',{})
vim.keymap.set('n',')','<Cmd>BufferNext<CR>',{})
vim.keymap.set('n','_','<Cmd>BufferClose<CR>',{})

require'bufferline'.setup{
  exclude_ft={'qf'},
  sidebar_filetypes={NvimTree=true},
  auto_hide=1
}
