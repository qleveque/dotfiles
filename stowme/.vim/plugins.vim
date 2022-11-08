call plug#begin('~/.vim_plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'dstein64/nvim-scrollview'
Plug 'farmergreg/vim-lastplace'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'romgrk/barbar.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/argtextobj.vim'
Plug 'voldikss/vim-floaterm'
Plug 'Yggdroot/indentLine'
call plug#end()

let g:coc_disable_startup_warning = 1
let g:floaterm_opener='edit'
let g:floaterm_width=0.85

lua << EOF
  require'colorizer'.setup()
  require'bufferline'.setup{exclude_ft={'qf'}}
  require'nvim-treesitter.configs'.setup{highlight={enable=true}}
  require'telescope'.setup{
    defaults={mappings={i={['<ESC>']=require('telescope.actions').close,['<C-V>']={'<C-R>+',type="command"}}}}
  }
EOF
