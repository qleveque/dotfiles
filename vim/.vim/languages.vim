autocmd FileType python setlocal sw=4 sts=4 ts=4
autocmd BufRead,BufNewFile *.aMod,*.mod,*.aMake set filetype=oberon
autocmd Syntax oberon source ~/.vim/syntax/oberon2.vim
autocmd BufRead,BufNewFile *.m4 set filetype=dockerfile
autocmd FileType oberon setlocal noexpandtab
