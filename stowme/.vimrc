colorscheme style
set cb^=unnamed,unnamedplus sd=!,'1000,<50,s10,h stl=%1*\ \%f%m\ %0*%= mousescroll=ver:2
set so=4 hls ic scs is nu lz list noswf udf et cul tgc ch=0 dip+=iwhite,vertical shm+=aI scl=number

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
xn . :norm! .<CR>
nn <Esc> :nohl<CR>
nm s ys
vm s S

" Easy life
nn V ggVG
xn à :norm! @q<CR>
nn à @q
vm <C-e> <C-y>,
im <C-e> <C-y>,
ino <C-v> <C-R>+
cno <C-v> <C-R>+
nn ç <Cmd>let @/='\<'.expand('<cword>').'\>'<bar>set hlsearch<CR>"_cgn
vn ç "xy<Cmd>let @/='\V'.escape(@x, '\\/')<bar>set hlsearch<CR>"_cgn
nn - :sil cprev<CR>
nn + :sil cnext<CR>
map H ?\C\<
map L /\C\<
map _ <Plug>(wildfire-fuel)V
vm - <Plug>(wildfire-water)V

" Shortcuts
map <C-f> :NvimTreeFindFile<CR>
map <C-n> :CocList -I symbols<CR>
map <C-t> :sil lua require'telescope.builtin'.find_files()<CR>
map <C-s> :sil lua require'telescope.builtin'.live_grep()<CR>
map <C-p> :sil lua require'telescope.builtin'.oldfiles()<CR>
map <C-g> :AerialOpen<CR>
map <C-q> ZQ

" Term
nn <silent> é :exe'sil !tmux splitw "run '.expand("%").'"'<CR>
nn <C-b>s :exe 'sil !tmux splitw -v -c "'.getcwd().'"'<CR>
nn <C-b>v :exe 'sil !tmux splitw -h -c "'.getcwd().'"'<CR>

" Coc
nn gd <Plug>(coc-definition)
nn gr <Plug>(coc-references)
xn \f <Plug>(coc-format-selected)
nn <CR> <Plug>(coc-codeaction-cursor)
ino <expr><CR> coc#pum#visible()?coc#pum#confirm():"\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
ino <expr><TAB> coc#pum#visible()?coc#pum#next(1):indent(".")<col(".")-1?coc#refresh():"\<TAB>"
ino <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Version Control
nn \d :exe'sil '.eval(tmux).'git difftool -y '.expand('%:t').'"'<CR>
nn \D :exe'sil '.eval(tmux).'tig status"'<CR>
nn \l :exe'sil '.eval(tmux).'tig --follow '.expand('%:t').'"'<CR>
nn \L :exe'sil '.eval(tmux).'tig"'<CR>
nn \b :exe'sil '.eval(tmux).'tig blame +'.line('.').' '.expand('%:t').'"'<CR>
no ]x /\v^[\=<>\|]{7}.*<CR>
no [x ?\v^[\=<>\|]{7}.*<CR>
nm dc [xjvv]xky?\v\<{7}.*<CR>vv/\v\>{7}.*<CR>dp<BS>

" Miscellaneous
let tmux="'!tmux neww -a \"cd '.fnamemodify(resolve(expand('%')),':h').'&&'"
let g:clipboard={'copy':{'+':'c','*':'c'},'paste':{'+':'p','*':'p'},'cache_enabled':0}
for k in split('hjklftpq','\zs')|exe 'imap <C-'.k.'> <Esc><C-'.k.'>'|endfor
au FileType * set formatoptions-=cro
let wild = ['a}', 'a]', 'a)', 'at', 'a>', 'ac', 'af']
let g:wildfire_objects = {'*':wild,'python':wild+['aiv'],'sh,zsh,bash':wild+['aIv']}
au User targets#mappings#user call targets#mappings#extend({'a': {}})

" Diff
if &diff 
  set noro
  nn <C-Q> :qa<CR>
  nn q :qa<CR>
  nn + ]c
  nn - [c
  nn gf :exe 'sil '.eval(tmux).'nvim "$FILE" +'.line('.').'"'<CR>
  let g:barbar_auto_setup=v:false
  let g:coc_start_at_startup=0
  au VimEnter * :windo set wrap nofen fdc=0 | :norm +-
endif

" Plugins
call plug#begin('~/.vim_plugged')
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'farmergreg/vim-lastplace'
  Plug 'gcmt/wildfire.vim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'mattn/emmet-vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'neoclide/coc.nvim',{'branch': 'release'}
  Plug 'numToStr/Comment.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'petertriho/nvim-scrollbar'
  Plug 'pocco81/auto-save.nvim'
  Plug 'romgrk/barbar.nvim'
  Plug 'roxma/vim-paste-easy'
  Plug 'sheerun/vim-polyglot'
  Plug 'stevearc/aerial.nvim'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'wellle/targets.vim'
call plug#end()
