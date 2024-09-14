let g:clipboard={'copy':{'+':'c'},'paste':{'+':'p'},'cache_enabled':0}
set ic scs nu list udf cul et lz noswf nowb so=4 ch=0 shm+=I scl=number cb=unnamedplus
set stl=%1*\ \%f%m%{reg_recording()!=''?'\ 󰑋':''}\ %0*%=

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
map <C-q> ZQ
nn V ggVG
xn à :norm! @q<CR>
nn à @q
ino <C-v> <C-R>+
cno <C-v> <C-R>+
nn ç <Cmd>let @/='\V\C\<'.expand('<cword>').'\>'<bar>set hls<CR>"_cgn
vn ç "xy<Cmd>let @/='\V\C'.escape(@x, '\\/')<bar>set hls<CR>"_cgn
nn - :sil cprev<CR>
nn + :sil cnext<CR>
nn é :exe'sil !wez split "run -p \"'.expand('%').'\""'<CR>
nn É :exe'sil !wez split run'<CR>
nn <C-g> :exe'sil !wez new "gitw '.nr2char(getchar()).' '.expand('%').' -l'.line('.').'"'<CR>

" Diff
if &diff
  nn <C-q> :qa<CR>
  nn + ]c
  nn - [c
  nn gf :exe 'sil !wez new "nvim "$FILE" +'.line('.').'"'<CR>
  au VimEnter * :windo set fdc=0 wrap noro nofen | :norm +-
  au BufWinEnter /tmp/* setlocal noma
  if len(argv()) == 3
    nn doh 1do
    nn dol 3do
    au VimEnter * :winc h
  end
end
