call plug#begin('~/.vim/plugged')
if !has('win32')|Plug 'romgrk/barbar.nvim'|endif
Plug 'christoomey/vim-tmux-navigator'
Plug 'dstein64/nvim-scrollview'
Plug 'dyng/ctrlsf.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'github/copilot.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/argtextobj.vim'
Plug 'voldikss/vim-floaterm'
Plug 'yggdroot/indentLine'

Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'posva/vim-vue'
Plug 'udalov/kotlin-vim'
call plug#end()

autocmd FileType * let b:coc_suggest_disable = 1
let bufferline = get(g:,'bufferline',
  \ {'auto_hide':v:true,'icons':v:false,'exclude_ft':['qf,ctrlsf']})
let g:coc_disable_startup_warning = 1
let g:copilot_no_tab_map = v:true
let g:ctrlsf_auto_focus = {"at":"start"}
let g:ctrlsf_mapping = {"openb":"<Enter>","next":"n","prev":"N"}
let g:floaterm_autoclose=2|let g:floaterm_opener='edit'
let g:floaterm_height=0.8|let g:floaterm_width=0.8
let g:fzf_preview_window = []
let g:loaded_netrw = 1|let g:loaded_netrwPlugin = 1
let g:user_emmet_leader_key='<C-Z>'
let floaterm_full='FloatermNew --height=&lines+1 --width=&columns+2'
let pyqo_f='echo `eval $PYQO_F_TARGET`'
let run=':w! | :FloatermNew --autoclose=0 --title=Zsh zsh -ic'
let tab="\<Tab>"

nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l
