call plug#begin('~/.vim_plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'dstein64/nvim-scrollview'
Plug 'farmergreg/vim-lastplace'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'
call plug#end()

let g:floaterm_opener='edit'
let g:floaterm_width=0.85
let g:coc_global_extensions=['coc-marketplace','coc-json','coc-tsserver','coc-ccls','coc-html',
  \ 'coc-pyright','coc-css','coc-highlight','coc-clangd']

lua << EOF
  require'bufferline'.setup{exclude_ft={'qf'}}
  require'telescope'.setup{defaults={mappings={
    i={['<ESC>']=require('telescope.actions').close,['<C-V>']={'<C-R>+',type="command"}}}}
  }
EOF
