set cb^=unnamed,unnamedplus shm+=aI sd=!,'1000,<50,s10,h stl=%1*\ \%f%m\ %0*%=
set so=4 hls ic scs is nu rnu lz list noswf udf et cul tgc ch=0 dip+=vertical
source ~/.vim/style.vim
source ~/.vim/plugins.vim
if filereadable(expand("~/.vim/specific.vim"))|source ~/.vim/specific.vim|endif

" Easy life
nn ' `
nn <BS> :nohl<CR>
nn <C-Q> ZQ
nn S f,a<CR><Esc>
nn U <C-R>
nn V ggVG
nn vv V
nn à @q
nn * *N
no D "_d
no C "_c
nn DD "_dd
nn CC "_cc
nn X "_x
ino <C-V> <C-R>+
cno <C-V> <C-R>+
vno * "xy/<C-R>x<CR>N
xno P "_c<C-R>+<Esc>
xno à :norm! @q<CR>
xno . :norm! .<CR>
map ç *cgn
map Ç *Cgn
map L /\C\<
map H ?\C\<
nm s ys
vm s S
vm <C-e> <C-y>,
im <C-e> <C-y>,

" Shortcuts
nn <C-f> :exe 'FloatermNew --title=─ vifm -c :only "%:p:h"'<CR>
nn <C-n> :CocList -I symbols<CR>
nn <C-t> :lua require'telescope.builtin'.find_files()<CR>
nn <C-s> :lua require'telescope.builtin'.live_grep()<CR>
nn <C-p> :lua require'telescope.builtin'.oldfiles()<CR>

" Buffers
nn <silent> ( :BufferPrevious<CR>
nn <silent> ) :BufferNext<CR>
nn <silent> _ :BufferClose<CR>
nn <silent>   :BufferMovePrevious<CR>
nn <silent> ° :BufferMoveNext<CR>

" Coc
nm gd <Plug>(coc-definition)
nm gr <Plug>(coc-references)
xm <leader>f <Plug>(coc-format-selected)
ino <silent><expr> <CR> coc#pum#visible()?coc#pum#confirm():"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
ino <silent><expr> <TAB> coc#jumpable()?"\<C-r>=coc#rpc#request('doKeymap',['snippets-expand-jump',''])\<CR>":
  \ coc#pum#visible()?coc#pum#next(1):col('.')-1&&getline('.')[col('.')-2]!~#'\s'?coc#refresh():"\<Tab>"
ino <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Diff
let diffs=['windo set wrap nofen fdc=0','nm <C-Q> :qa<CR>','map + ]czz','map - [czz','norm 1G+-']
ca diff Diff|com Diff :exe 'windo diffthis|for c in diffs|exe c|endfor'
au VimEnter * if !&diff|exe 'map - :cprev<CR>'|exe 'map + :cnext<CR>'|else|for c in diffs|exe c|endfor|endif

" Term
tno <C-A> <C-\><C-N>
nn <silent> é :exe ':w! \| :FloatermNew --autoclose=0 --title=─ run '.'"'.expand("%").'"'<CR>
nn <silent> <C-W><C-W> :FloatermToggle<CR>
tno <silent> <C-W><C-W> <C-\><C-n>:FloatermToggle<CR>
nn <C-b>s :exe "silent !tmux split-window -v -c \"".getcwd()."\""<CR>
nn <C-b>v :exe "silent !tmux split-window -h -c \"".getcwd()."\""<CR>

" Git
let tc="'--height=&lines+1 --width=&columns+2 cd '.fnamemodify(resolve(expand('%')),':h')"
nn <leader>D :exe "FloatermNew ".eval(tc)."&&tig status"<CR>
nn <leader>L :exe "FloatermNew ".eval(tc)."&&tig"<CR>
nn <leader>b :exe "FloatermNew ".eval(tc)."&&tig blame +".line(".")." ".expand('%:t')<CR>
nn <leader>d :exe "FloatermNew ".eval(tc)."&&git difftool -y ".expand('%:t')<CR>
nn <leader>l :exe "FloatermNew ".eval(tc)."&&tig --follow ".expand('%:t')<CR>
