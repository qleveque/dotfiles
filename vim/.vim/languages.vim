autocmd FileType cpp,javascript,json,nsis,html,yaml,zsh,sh setlocal shiftwidth=2 softtabstop=2

autocmd BufRead,BufNewFile *.aMod set filetype=oberon
autocmd Syntax oberon source ~/.vim/syntax/oberon2.vim
