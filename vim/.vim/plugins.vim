call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'dstein64/nvim-scrollview'
Plug 'farmergreg/vim-lastplace'
" Plug 'github/copilot.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
Plug 'romgrk/barbar.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/argtextobj.vim'
Plug 'voldikss/vim-floaterm'
call plug#end()

let g:coc_disable_startup_warning = 1
let g:copilot_no_tab_map=v:true
let g:floaterm_opener='edit'
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1
let g:user_emmet_leader_key='<C-Z>'
let g:floaterm_height=0.8
let g:floaterm_width=0.8

lua << EOF
  require'bufferline'.setup{auto_hide=true,exclude_ft={'qf'}}
  require'nvim-treesitter.configs'.setup{highlight={enable=true}}
  require'telescope'.setup{defaults={mappings={i={
    ['<ESC>']=require('telescope.actions').close,
    ['<C-V>']={'<C-R>+',type="command"},
  }}}}
  require'colorizer'.setup()
EOF
