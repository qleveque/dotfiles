set clipboard^=unnamed,unnamedplus
set mousescroll=ver:1 so=4 ch=0 scl=number shortmess+=I
set ic scs nu list noswf udf cul nowrap nowb

" Vim corrections
nn ' `
vn v V
nn U <C-R>
vn $ $h
xn . :norm! .<CR>
nn <Esc> :nohl<CR>
xn p P
xn P p
no c "_c
nn cc "_cc
no d "_d
nn dd "_dd
no x d

" Easy life
nn V ggVG
xn à :norm! @q<CR>
nn à @q
ino <C-v> <C-R>+
cno <C-v> <C-R>+
nn ç <Cmd>let @/='\V\C\<'.expand('<cword>').'\>'<bar>set hls<CR>"_cgn
vn ç "xy<Cmd>let @/='\V\C'.escape(@x, '\\/')<bar>set hls<CR>"_cgn
nn - :sil cprev<CR>
nn + :sil cnext<CR>

" Ctrl shortcuts
map <C-f> :NvimTreeFindFile<CR>
map <C-n> :CocList -I symbols<CR>
map <C-t> :sil lua require'telescope.builtin'.find_files()<CR>
map <C-p> :sil lua require'telescope.builtin'.oldfiles()<CR>
map <C-s> :sil lua require'telescope.builtin'.live_grep()<CR>
map <C-r> :sil lua require'spectre'.toggle()<CR>
map <C-g> :AerialOpen<CR>
map <C-q> ZQ

" Tabs
nn <M-h> <Cmd>BufferPrevious<CR>
nn <M-l> <Cmd>BufferNext<CR>
nn <M-j> <Cmd>BufferClose<CR>
nn <M-k> <Cmd>BufferRestore<CR>

" Term
nn <silent> é :exe'sil !tmux splitw "run -p \"'.expand("%").'\""'<CR>
nn <C-b>s :exe 'sil !tmux splitw -v -c "'.getcwd().'"'<CR>
nn <C-b>v :exe 'sil !tmux splitw -h -c "'.getcwd().'"'<CR>
nn \d :exe'sil '.eval(tmux).'git difftool '.expand('%:t').'"'<CR>
nn \D :exe'sil '.eval(tmux).'tig status"'<CR>
nn \l :exe'sil '.eval(tmux).'tig '.expand('%:t').'"'<CR>
nn \L :exe'sil '.eval(tmux).'tig"'<CR>
nn \b :exe'sil '.eval(tmux).'tig blame +'.line('.').' '.expand('%:t').'"'<CR>

" Coc.nvim
nn gd <Plug>(coc-definition)
nn gr <Plug>(coc-references)
nn gh :call CocAction("diagnosticInfo")<CR>'
nn K :call CocActionAsync('doHover')<CR>
xn \f <Plug>(coc-format-selected)
au FileType * if &ft != 'qf'|nn <buffer> <CR> <Plug>(coc-codeaction-cursor)|endif
ino <expr><CR> coc#pum#visible()?coc#pum#confirm():
  \ "\<CMD>call feedkeys(v:lua.require('nvim-autopairs').autopairs_cr(), 'in')\<CR>"
ino <expr><TAB> coc#pum#visible()?coc#pum#next(1):
  \ indent(".")<col(".")-1?coc#refresh():"\<TAB>"
ino <expr><S-TAB> coc#pum#visible()?coc#pum#prev(1):"\<C-h>"

" Miscellaneous
let tmux="'!tmux neww -a \"cd '.fnamemodify(resolve(expand('%')),':h').'&&'"
let g:clipboard={'copy':{'+':'c','*':'c'},'paste':{'+':'p','*':'p'},'cache_enabled':0}
for k in split('hjklftpqgr','\zs')|exe 'imap <C-'.k.'> <Esc><C-'.k.'>'|endfor
au FileType * set formatoptions-=cro
if &diff
  set noro dip+=iwhite,vertical
  nn <C-Q> :qa<CR>
  nn q :qa<CR>
  nn + ]c
  nn - [c
  nn gf :exe 'sil '.eval(tmux).'nvim "$FILE" +'.line('.').'"'<CR>
  au VimEnter * :windo set nofen fdc=0 | :norm +-
  au BufWinEnter /tmp/* setlocal nomodifiable
endif
