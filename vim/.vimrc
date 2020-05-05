source ~/.vimrc_base

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

""""""""""""""""""""""""""""""
" => Persistent undo
""""""""""""""""""""""""""""""
set undodir=~/.vim/undodir
set undofile

""""""""""""""""""""""""""""""
" => Run
""""""""""""""""""""""""""""""
nnoremap <F9> :!%:p

""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""
set runtimepath^=~/.vim/emmet-vim
set runtimepath^=~/.vim/vim-airline
set runtimepath^=~/.vim/vim-commentary
set runtimepath^=~/.vim/vim-surround
set runtimepath^=~/.vim/vim-tmux-navigator
set runtimepath^=~/.vim/fzf
set runtimepath^=~/.vim/fzf.vim

