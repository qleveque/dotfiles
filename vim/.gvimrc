source ~/.vimrc

set guioptions-=T
set guioptions-=m
set guioptions-=e
set guitablabel=%M\ %t
if has('gui_win32')
    set guifont=Consolas:h11
else
    set guifont=DejaVu\ Sans\ Mono\ 12
endif

if has("win32")
    set shell=C:\Windows\Sysnative\wsl.exe
    set shellpipe=|
    set shellredir=>
    set shellcmdflag=
endif

