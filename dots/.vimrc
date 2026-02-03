set ic scs nu list udf cul et lz noswf nowb so=4 ch=0 shm+=I scl=number cb=unnamedplus ts=2 sw=0 lbr
set diffopt+=iwhite stl=%1*\ \%f%m%{reg_recording()!=''?'\ 󰑋\ '.reg_recording():''}\ %0*%= 

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
xn <silent> à :norm! @q<CR>
nn à @q
ino <C-v> <C-R>+
cno <C-v> <C-R>+
nn ç <Cmd>let @/='\V\C\<'.expand('<cword>').'\>'<bar>set hls<CR>"_cgn
vn ç "xy<Cmd>let @/='\V\C'.escape(@x, '\\/')<bar>set hls<CR>"_cgn
nn <silent> - :sil cprev<CR>
nn <silent> + :sil cnext<CR>
nn <silent> é :exe'sil !wez_wrap split "run -p \"'.expand('%').'\""'<CR>
nn <silent> É :exe'sil !wez_wrap split run'<CR>
nn <silent> <C-g> :exe'sil !git_wrap '.nr2char(getchar()).' -f'.expand('%').' -l'.line('.')<CR>

" Diff
if &diff
  nn <silent> <C-q> :qa<CR>
  nn + ]c
  nn - [c
  au VimEnter * :windo set fdc=0 wrap noro nofen | :norm +-
end
