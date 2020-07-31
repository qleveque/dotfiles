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
" => Vim tree
""""""""""""""""""""""""""""""
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
command! Tree :Vexplore
cnoreabbrev tree Tree

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
set runtimepath^=~/.vim/fugitive

""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""
nnoremap <C-f> :Rg 

""""""""""""""""""""""""""""""
" => Fugitive
""""""""""""""""""""""""""""""
command! Diffs :Git difftool -y
command! Diff :Gdiff
command! Commit :BCommits

""""""""""""""""""""""""""""""
" => Tags
""""""""""""""""""""""""""""""
command! Ctags :!ctags -f '.tags' -R . 
cnoreabbrev ctags Ctags
nnoremap gd <C-]>
nnoremap gD gd
set tags=.tags
set path=.

