set cb^=unnamed,unnamedplus udir=~/.vim_undo dip+=vertical enc=UTF8 shm+=aoOtI
set so=4 scl=no mouse=a sd='1000,<50,s10,h,rA:,rB: stl=%1*\ \%f%m\ %0*%= 
set ic scs is nu rnu lz list noswf udf et cul nomagic tgc

source ~/.vim/style.vim
source ~/.vim/plugins.vim
if filereadable(expand("~/.vim/specific.vim"))|source ~/.vim/specific.vim|endif

" Easy life
nn ' `
nn <BS> :nohl<CR>
nn <C-Q> ZQ
nn <C-R> :e!<CR>
nn S f,a<CR><Esc>
nn U <C-R>
nn V ggVG
nn vv V
nn à @q
xno à :norm! @q<CR>
vno . :normal .<CR>
ino <C-V> <C-R>+
cno <C-V> <C-R>+
no D "_d
no C "_c
nn DD "_dd
nn CC "_cc
nn X "_x
xno P "_c<C-R>+<Esc>
vno * "xy/\V<C-R>x<CR>
vno # "xy?\V<C-R>x<CR>
map ç #NCgn
map Ç #NCgN
map L /\V\C\<
map H ?\V\C\<

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
nm <leader>s :%s/\s\+$//e<CR>
im <script><expr> <S-Tab> copilot#Accept("\<CR>")
nm ù <Plug>(emmet-expand-abbr)
au VimEnter * if !&diff|exe 'map - :cprev<CR>'|exe 'map + :cnext<CR>'|endif
nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)
xmap <leader>f <Plug>(coc-format-selected)
inoremap <expr> <Tab> pumvisible()?"\<C-n>":
  \col('.')-1&&getline('.')[col('.')-2]!~#'\s'?coc#refresh():"\<Tab>"
inoremap <expr> <CR> pumvisible()?coc#_select_confirm():"\<CR>"

" Buffers
nn <silent> ( :BufferPrevious<CR>
nn <silent> ) :BufferNext<CR>
nn <silent> _ :BufferClose<CR>
nn <silent>   :BufferMovePrevious<CR>
nn <silent> ° :BufferMoveNext<CR>

" Term
let run=':w! | :FloatermNew --autoclose=0 --title=─ run '
nn <silent> é :exe run.'"'.expand("%").'"'<CR>
tno <C-A> <C-\><C-N>
nn <silent> <C-W><C-W> :FloatermToggle<CR>
tno <silent> <C-W><C-W> <C-\><C-n>:FloatermToggle<CR>
nn <C-b>s :exe "silent !tmux split-window -v -c \"".getcwd()."\""<CR>
nn <C-b>v :exe "silent !tmux split-window -h -c \"".getcwd()."\""<CR>

" Git
let diff_cmds=['norm 1G+-', 'windo set wrap nofen fdc=0', 'nm <C-Q> :qa<CR>',
              \'map + ]czz', 'map - [czz']
au VimEnter * if &diff|for c in diff_cmds|exe c|endfor|endif
ca diff Diff|com Diff :exe 'windo diffthis|windo set wrap nofen fdc=0'
let floaterm_full="'FloatermNew --height=&lines+1 --width=&columns+2"
let tc=floaterm_full." cd '.fnamemodify(resolve(expand('%')), ':h')"
nn <leader>D :exe eval(tc)."&&tig status"<CR>
nn <leader>L :exe eval(tc)."&&tig"<CR>
nn <leader>b :exe eval(tc)."&&tig blame +".line(".")." ".expand('%:t')<CR>
nn <leader>d :exe eval(tc)."&&git difftool -y ".expand('%:t')<CR>
nn <leader>l :exe eval(tc)."&&tig --follow ".expand('%:t')<CR>
