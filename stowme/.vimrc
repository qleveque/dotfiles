set cb^=unnamed,unnamedplus udir=~/.vim_undo dip+=vertical enc=UTF8 shm+=aI
set so=4 scl=no sd='1000,<50,s10,h,rA:,rB: stl=%1*\ \%f%m\ %0*%= ch=0
set ic scs is nu rnu lz list noswf udf et cul tgc
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
xno à :norm! @q<CR>
vno . :norm! .<CR>
ino <C-V> <C-R>+
cno <C-V> <C-R>+
no D "_d
no C "_c
nn DD "_dd
nn CC "_cc
nn X "_x
xno P "_c<C-R>+<Esc>
vno * "xy/<C-R>x<CR>N
map ç *Cgn
map Ç *CgN
map L /\C\<
map H ?\C\<

" Shortcuts
nn <C-f> :exe 'FloatermNew --title=─ vifm -c :only "%:p:h"'<CR>
nn <C-n> :CocList -I symbols<CR>
nn <C-t> :lua require'telescope.builtin'.find_files()<CR>
nn <C-s> :lua require'telescope.builtin'.live_grep()<CR>
nn <C-p> :lua require'telescope.builtin'.oldfiles()<CR>

" Secondary shortcuts
nm s ys
nm ss yss
vm s S
ino <S-Tab> <Plug>(emmet-expand-abbr)
au VimEnter * if !&diff|exe 'map - :cprev<CR>'|exe 'map + :cnext<CR>'|endif
nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)
ino <silent><expr> <CR> coc#pum#visible()?coc#pum#confirm():"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
ino <silent><expr> <TAB> coc#pum#visible()?coc#pum#next(1):col('.')-1&&getline('.')[col('.')-2]!~#'\s'?coc#refresh():"\<Tab>"

" Buffers
nn <silent> ( :BufferPrevious<CR>
nn <silent> ) :BufferNext<CR>
nn <silent> _ :BufferClose<CR>
nn <silent>   :BufferMovePrevious<CR>
nn <silent> ° :BufferMoveNext<CR>

" Term
tno <C-A> <C-\><C-N>
nn <silent> é :exe ':w! \| :FloatermNew --autoclose=0 --title=─ run '.'"'.expand("%").'"'<CR>
nn <silent> <C-W><C-W> :FloatermToggle<CR>
tno <silent> <C-W><C-W> <C-\><C-n>:FloatermToggle<CR>
nn <C-b>s :exe "silent !tmux split-window -v -c \"".getcwd()."\""<CR>
nn <C-b>v :exe "silent !tmux split-window -h -c \"".getcwd()."\""<CR>

" Git
let diffs=['windo set wrap nofen fdc=0','nm <C-Q> :qa<CR>','map + ]czz','map - [czz','norm 1G+-']
au VimEnter * if &diff|for c in diffs|exe c|endfor|endif
ca diff Diff|com Diff :exe 'windo diffthis|for c in diffs|exe c|endfor'
let tc="'--height=&lines+1 --width=&columns+2 cd '.fnamemodify(resolve(expand('%')),':h')"
nn <leader>D :exe "FloatermNew ".eval(tc)."&&tig status"<CR>
nn <leader>L :exe "FloatermNew ".eval(tc)."&&tig"<CR>
nn <leader>b :exe "FloatermNew ".eval(tc)."&&tig blame +".line(".")." ".expand('%:t')<CR>
nn <leader>d :exe "FloatermNew ".eval(tc)."&&git difftool -y ".expand('%:t')<CR>
nn <leader>l :exe "FloatermNew ".eval(tc)."&&tig --follow ".expand('%:t')<CR>
