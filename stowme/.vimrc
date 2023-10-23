colorscheme style
set cb^=unnamed,unnamedplus sd=!,'1000,<50,s10,h stl=%1*\ \%f%m\ %0*%= mousescroll=ver:2
set so=4 hls ic scs is nu lz list noswf udf et cul tgc ch=0 dip+=vertical shm+=aI noro

" No registers
no c "_c
nn cc "_cc
no d "_d
nn dd "_dd
no x d

" Easy life
map <C-q> ZQ 
ino <C-v> <C-R>+
cno <C-v> <C-R>+
nn <BS> :nohl<CR>
nn ' `
nn U <C-R>
no V ggVG
nn vv V
nn S f,a<CR><Esc>
nm s ys
vm s S
vm <C-e> <C-y>,
im <C-e> <C-y>,
nn à @q
xno à :norm! @q<CR>
xno . :norm! .<CR>
map ç <Cmd>let @/='\<'.expand('<cword>').'\>'<bar>set hlsearch<CR>cgn
vm ç "xy<Cmd>let @/=@x<bar>set hlsearch<CR>cgn
nm - :sil cprev<CR>
nm + :sil cnext<CR>
map ( ?\C\<
map ) /\C\<

" Shortcuts
map <C-f> :NvimTreeFindFileToggle<CR>
map <C-n> :CocList -I symbols<CR>
map <C-t> :sil lua require'telescope.builtin'.find_files()<CR>
map <C-s> :sil lua require'telescope.builtin'.live_grep()<CR>
map <C-p> :sil lua require'telescope.builtin'.oldfiles()<CR>

" Coc
nm gd <Plug>(coc-definition)
nm gr <Plug>(coc-references)
xm \f <Plug>(coc-format-selected)
nm \f <Plug>(coc-format)
nm <M-CR> <Plug>(coc-codeaction-cursor)
ino <expr><CR> coc#pum#visible()?coc#pum#confirm():"\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
ino <expr><TAB> coc#pum#visible()?coc#pum#next(1):indent(".")<col(".")-1?coc#refresh():"\<TAB>"

" Term
nn <silent> é :exe'sil !tmux splitw "run \"'.expand("%").'\""'<CR>
nn <C-b>s :exe 'sil !tmux splitw -v -c "'.getcwd().'"'<CR>
nn <C-b>v :exe 'sil !tmux splitw -h -c "'.getcwd().'"'<CR>

" Version Control
let df='windo set wrap nofen fdc=0|nm <C-Q> :qa<CR>|nm + ]czt|nm - [czt|norm +-'
au VimEnter * if &diff|exe df|end
let rs="'!tmux neww -a \"cd '.fnamemodify(resolve(expand('%')),':h').'&&'"
nn \d :exe'sil '.eval(rs).'git difftool -y '.expand('%:t').'"'<CR>
nn \D :exe'sil '.eval(rs).'tig status"'<CR>
nn \l :exe'sil '.eval(rs).'tig --follow '.expand('%:t').'"'<CR>
nn \L :exe'sil '.eval(rs).'tig"'<CR>
nn \b :exe'sil '.eval(rs).'tig blame +'.line('.').' '.expand('%:t').'"'<CR>
no ]x /\v^[\=<>\|]{7}.*<CR>
no [x ?\v^[\=<>\|]{7}.*<CR>
nm dc [xjV]xky?\v\<{7}.*<CR>V/\v\>{7}.*<CR>DP<BS>

" Miscellaneous
autocmd FileType * set formatoptions-=cro
im <script><silent><nowait><expr> <S-TAB> codeium#Accept()
let g:codeium_disable_bindings = 1
let g:clipboard={'copy':{'+':'c','*':'c'},'paste':{'+':'p','*':'p'},'cache_enabled':0}
let g:scrollview_signs_on_startup = []
for k in split('abcdefghijklmnopqrstuwxyz','\zs')|exe 'imap <C-'.k.'> <Esc><C-'.k.'>'|endfor

" Plugins
call plug#begin('~/.vim_plugged')
  Plug 'Exafunction/codeium.vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'dstein64/nvim-scrollview'
  Plug 'farmergreg/vim-lastplace'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'mattn/emmet-vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'neoclide/coc.nvim',{'branch': 'release'}
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'romgrk/barbar.nvim'
  Plug 'roxma/vim-paste-easy'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
call plug#end()
lua require('tree')
lua require('bar')
