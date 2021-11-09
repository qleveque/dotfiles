autocmd FileType python setlocal shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile *.aMod set filetype=oberon
autocmd Syntax oberon source ~/.vim/syntax/oberon2.vim
autocmd FileType oberon setlocal noexpandtab
