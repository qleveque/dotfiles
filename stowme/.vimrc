colorscheme style
set cb^=unnamed,unnamedplus sd=!,'1000,<50,s10,h stl=%1*\ \%f%m\ %0*%= mousescroll=ver:2
set so=4 hls ic scs is nu lz list noswf udf et cul tgc ch=0 dip+=iwhite,vertical shm+=aI noro

" No registers
no c "_c
nn cc "_cc
no d "_d
nn dd "_dd
no x d

" Char operations
nm X xl
nm D dl
nm Y yl
nm C cl

" Vim corrections
nn ' `
nn U <C-R>
nn vv V
vn $ $h
nm s ys
vm s S
xn . :norm! .<CR>

" Easy life
nn <BS> :nohl<CR>
no V ggVG
xn à :norm! @q<CR>
nn à @q
vm <C-e> <C-y>,
im <C-e> <C-y>,
ino <C-v> <C-R>+
cno <C-v> <C-R>+
nn ç <Cmd>let @/='\<'.expand('<cword>').'\>'<bar>set hlsearch<CR>"_cgn
vn ç "xy<Cmd>let @/=@x<bar>set hlsearch<CR>"_cgn
nn - :sil cprev<CR>
nn + :sil cnext<CR>
map ( ?\C\<
map ) /\C\<

" Shortcuts
map <C-f> :NvimTreeFindFileToggle<CR>
map <C-n> :CocList -I symbols<CR>
map <C-t> :sil lua require'telescope.builtin'.find_files()<CR>
map <C-s> :sil lua require'telescope.builtin'.live_grep()<CR>
map <C-p> :sil lua require'telescope.builtin'.oldfiles()<CR>
map <C-q> ZQ

" Coc
nn gd <Plug>(coc-definition)
nn gr <Plug>(coc-references)
xn \f <Plug>(coc-format-selected)
nn \f <Plug>(coc-format)
nn <C-;> <Plug>(coc-codeaction-cursor)
ino <expr><CR> coc#pum#visible()?coc#pum#confirm():"\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
ino <expr><TAB> coc#pum#visible()?coc#pum#next(1):indent(".")<col(".")-1?coc#refresh():"\<TAB>"

" Term
nn <silent> é :exe'sil !tmux splitw "run '.expand("%").'"'<CR>
nn <C-b>s :exe 'sil !tmux splitw -v -c "'.getcwd().'"'<CR>
nn <C-b>v :exe 'sil !tmux splitw -h -c "'.getcwd().'"'<CR>

" Version Control
let df='windo set wrap nofen fdc=0|nm <C-Q> :qa<CR>|nm + ]c|nm - [c|norm +-'
au VimEnter * if &diff|exe df|end
let rs="'!tmux neww -a \"cd '.fnamemodify(resolve(expand('%')),':h').'&&'"
nn \d :exe'sil '.eval(rs).'git difftool -y '.expand('%:t').'"'<CR>
nn \D :exe'sil '.eval(rs).'tig status"'<CR>
nn \l :exe'sil '.eval(rs).'tig --follow '.expand('%:t').'"'<CR>
nn \L :exe'sil '.eval(rs).'tig"'<CR>
nn \b :exe'sil '.eval(rs).'tig blame +'.line('.').' '.expand('%:t').'"'<CR>
no ]x /\v^[\=<>\|]{7}.*<CR>
no [x ?\v^[\=<>\|]{7}.*<CR>
nm dc [xjvv]xky?\v\<{7}.*<CR>vv/\v\>{7}.*<CR>dp<BS>

" Miscellaneous
let g:clipboard={'copy':{'+':'c','*':'c'},'paste':{'+':'p','*':'p'},'cache_enabled':0}
for k in split('hjklftpq','\zs')|exe 'imap <C-'.k.'> <Esc><C-'.k.'>'|endfor
au FileType * set formatoptions-=cro

" Plugins
call plug#begin('~/.vim_plugged')
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'farmergreg/vim-lastplace'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'mattn/emmet-vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'neoclide/coc.nvim',{'branch': 'release'}
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'petertriho/nvim-scrollbar'
  Plug 'pocco81/auto-save.nvim'
  Plug 'romgrk/barbar.nvim'
  Plug 'roxma/vim-paste-easy'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'wellle/targets.vim'
call plug#end()
