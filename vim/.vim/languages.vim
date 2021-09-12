autocmd FileType cpp,javascript,nsis,html,yaml setlocal shiftwidth=2 softtabstop=2
au BufRead,BufNewFile *.aMod set filetype=oberon
au! Syntax oberon source ~/.vim/syntax/oberon2.vim
