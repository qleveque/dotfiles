set ic scs nu list udf cul et lz noswf nowrap nowb so=4 ch=0 shm+=I
set sd=!,'1000,<50,s10,h cb=unnamedplus scl=number stl=%1*\ \%f%m\ %0*%=
let tmux="'!tmux neww -a \"cd '.fnamemodify(resolve(expand('%')),':h').'&&'"
let g:clipboard={'copy':{'+':'c'},'paste':{'+':'p'},'cache_enabled':0}
au FileType * set fo-=cro

" Vim corrections
nn ' `
vn v V
nn U <C-R>
vn $ $h
xn . :norm! .<CR>
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
map <C-q> ZQ

" Term
nn <silent> é :exe'sil !tmux splitw "run -p \"'.expand("%").'\""'<CR>
nn <C-b>s :exe'sil !tmux splitw -v -c "'.getcwd().'"'<CR>
nn <C-b>v :exe'sil !tmux splitw -h -c "'.getcwd().'"'<CR>
nn \d :exe'sil '.eval(tmux).'git difftool '.expand('%:t').'"'<CR>
nn \D :exe'sil '.eval(tmux).'tig status"'<CR>
nn \l :exe'sil '.eval(tmux).'tig '.expand('%:t').'"'<CR>
nn \L :exe'sil '.eval(tmux).'tig"'<CR>
nn \b :exe'sil '.eval(tmux).'tig blame +'.line('.').' '.expand('%:t').'"'<CR>

" Diff
if &diff
  nn <C-q> :qa<CR>
  nn + ]c
  nn - [c
  nn gf :exe 'sil '.eval(tmux).'nvim "$FILE" +'.line('.').'"'<CR>
  au VimEnter * :windo set fdc=0 wrap noro nofen | :norm +-
  au BufWinEnter /tmp/* setlocal noma
end
