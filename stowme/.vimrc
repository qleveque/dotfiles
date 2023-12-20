colorscheme style
set cb^=unnamed,unnamedplus sd=!,'1000,<50,s10,h stl=%1*\ \%f%m\ %0*%= mousescroll=ver:2
set so=4 hls ic scs is nu lz list noswf udf et cul tgc ch=0 dip+=iwhite,vertical shm+=aI scl=number

" Vim corrections
nn ' `
vn v V
nn U <C-R>
vn $ $h
xn . :norm! .<CR>
nn <Esc> :nohl<CR>
nm s ys
vm s S

" No registers
no c "_c
nn cc "_cc
no d "_d
nn dd "_dd
no x d
xn p P
xn P p

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
no <Space> :lua require('leap').leap{target_windows={vim.fn.win_getid()}}<CR>

" Shortcuts
map <C-f> :NvimTreeFindFile<CR>
map <C-n> :CocList -I symbols<CR>
map <C-t> :sil lua require'telescope.builtin'.find_files()<CR>
map <C-s> :sil lua require'telescope.builtin'.live_grep()<CR>
map <C-p> :sil lua require'telescope.builtin'.oldfiles()<CR>
map <C-g> :AerialOpen<CR>
map <C-q> ZQ

" Tabs
nn <M-h> <Cmd>BufferPrevious<CR>
nn <M-l> <Cmd>BufferNext<CR>
nn <M-j> <Cmd>BufferClose<CR>
nn <M-k> <Cmd>BufferRestore<CR>

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
nm dc [xjvV]xky?\v\<{7}.*<CR>vV/\v\>{7}.*<CR>dp<BS>

" Miscellaneous
let tmux="'!tmux neww -a \"cd '.fnamemodify(resolve(expand('%')),':h').'&&'"
let g:clipboard={'copy':{'+':'c','*':'c'},'paste':{'+':'p','*':'p'},'cache_enabled':0}
for k in split('hjklftpq','\zs')|exe 'imap <C-'.k.'> <Esc><C-'.k.'>'|endfor
au FileType * set formatoptions-=cro

" Diff
if &diff
  set noro
  nn <C-Q> :qa<CR>
  nn q :qa<CR>
  nn + ]c
  nn - [c
  nn gf :exe 'sil '.eval(tmux).'nvim "$FILE" +'.line('.').'"'<CR>
  au VimEnter * :windo set wrap nofen fdc=0 | :norm +-
endif
