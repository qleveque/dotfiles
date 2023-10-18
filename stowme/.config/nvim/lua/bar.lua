vim.keymap.set('n','<M-j>','<Cmd>BufferPrevious<CR>',{})
vim.keymap.set('n','<M-k>','<Cmd>BufferNext<CR>',{})
vim.keymap.set('n','<M-i>','<Cmd>BufferClose<CR>',{})

require'bufferline'.setup{
  exclude_ft={'qf'},
  sidebar_filetypes={
    NvimTree={
      text=' '..vim.fn.fnamemodify(vim.fn.getcwd(), ":t")..'/'
    }
  },
  auto_hide=1
}
