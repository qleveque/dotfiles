set clipboard^=unnamed,unnamedplus udir=~/.vim_undo dip+=vertical enc=UTF8
set lz list noswf udf si et shm+=aoOtI mouse=a shada='1000,<50,s10,h,rA:,rB:
set cul nomagic ignorecase smartcase incsearch number relativenumber scrolloff=4
set sts=2 sw=2 ts=2 scl=no termguicolors bg=dark statusline=%1*\ \%f%m\ %0*%= 

source ~/.vim/style.vim
source ~/.vim/plugins.vim
if filereadable("~/.vim/specific.vim")|source ~/.vim/specific.vim|endif

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
nn <C-n> :lua require'telescope.builtin'.lsp_dynamic_workspace_symbols()<CR>
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

" Buffers
nn <silent> ( :BufferPrevious<CR>
nn <silent> ) :BufferNext<CR>
nn <silent> _ :BufferClose<CR>
nn <silent>   :BufferMovePrevious<CR>
nn <silent> ° :BufferMoveNext<CR>

" Term
let run=':w! | :FloatermNew --autoclose=0 --title=─ zsh -ic'
nn <silent> é :exe run.' "run '.expand("%").'"'<CR>
tno <C-A> <C-\><C-N>
nn <silent> <C-W><C-W> :FloatermToggle<CR>
tno <silent> <C-W><C-W> <C-\><C-n>:FloatermToggle<CR>
nn <C-b>s :exe "silent !tmux split-window -v -c \"".getcwd()."\""<CR>
nn <C-b>v :exe "silent !tmux split-window -h -c \"".getcwd()."\""<CR>

" Git
let diff_cmds=['norm 1G+-', 'windo set wrap nofen fdc=0', 'nm <C-Q> :qa<CR>',
              \'map + ]czz', 'map - [czz']
au VimEnter * if &diff|for c in diff_cmds|exe c|endfor|endif
com Diff :exe 'windo diffthis|windo set wrap nofen fdc=0'
let tc="'FloatermNew --height=&lines+1 --width=&columns+2 cd '.expand('%:p:h')"
nn <leader>D :exe eval(tc)."&&tig status"<CR>
nn <leader>L :exe eval(tc)."&&tig"<CR>
nn <leader>b :exe eval(tc)."&&tig blame +".line(".")." ".expand('%:t')<CR>
nn <leader>d :exe eval(tc)."&&git difftool -y ".expand('%:t')<CR>
nn <leader>l :exe eval(tc)."&&tig --follow ".expand('%:t')<CR>
