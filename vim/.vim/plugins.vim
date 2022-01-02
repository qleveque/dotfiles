call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'dstein64/nvim-scrollview'
Plug 'dyng/ctrlsf.vim'
Plug 'github/copilot.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'liuchengxu/vista.vim'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/argtextobj.vim'
Plug 'voldikss/vim-floaterm'
Plug 'yggdroot/indentLine'

if !has('win32')
  Plug 'romgrk/barbar.nvim'
endif

Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'posva/vim-vue'
Plug 'udalov/kotlin-vim'

call plug#end()

let bufferline = get(g:, 'bufferline', {'auto_hide' : v:true})
let g:coc_disable_startup_warning = 1
let g:copilot_no_tab_map = v:true
let g:ctrlsf_auto_focus = {"at": "start"}
let g:ctrlsf_mapping = {"openb": "<Enter>", "next": "n", "prev": "N"}
let g:floaterm_autoclose=2
let g:floaterm_height=0.8
let g:floaterm_opener='edit'
let g:floaterm_width=0.8
let g:fzf_preview_window = []
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:user_emmet_leader_key='<C-Z>'
let g:vista_close_on_jump = 1
let g:vista_default_executive = 'coc'
let g:vista_ignore_kinds = ['Variable']

autocmd FileType * let b:coc_suggest_disable = 1
