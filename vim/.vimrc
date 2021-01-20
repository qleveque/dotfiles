" basic.vim
source ~/.vim/basic.vim
let mapleader = "\\"
noremap 0 0
set stal=1
set statusline=\ %<%F\ (%{&ff})%m%=%5l/%L%4v\ "

" coc.vim
source ~/.vim/coc.vim
let g:coc_disable_startup_warning = 1
nnoremap <leader>i :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
nnoremap <leader>f :call CocAction('format')<CR>
nmap <M-CR> :CocFix<CR>
if !has('nvim')
    execute "set <M-CR>=\<esc>\<cr>"
endif
inoremap <silent><expr> <Enter> pumvisible() ? coc#_select_confirm() : "<CR>"
command! CocMarket :execute "CocList marketplace"

" Miscellaneous
set t_ut=
set nocompatible
set cursorline
set mouse=a
set showbreak=►►►
set shortmess+=I
set number relativenumber
set magic!
set diffopt+=vertical

nnoremap <C-q> :q<CR>
xnoremap @ :norm! @
set termwinsize=15x0

" Clipboard preferences
set clipboard^=unnamed,unnamedplus
inoremap <C-V> <C-R>"

nnoremap D "_d
nnoremap DD "_dd
xnoremap D "_d
nnoremap CC "_cc
nnoremap C "_c
xnoremap C "_c
xnoremap P "_dP

" Search
nnoremap * *N
nnoremap # #N
vnoremap * "xy/<C-R>x<CR>N
vnoremap # "xy?<C-R>x<CR>N
onoremap n gn
onoremap N gN
nnoremap <BackSpace> :nohl<cr>
nnoremap // /<C-R>"<CR>

" Remove trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()
nnoremap <leader>tr :call CleanExtraSpaces()<CR>

" Persistent undo
set undodir=~/.vim/undodir
set undofile

" Style
highlight Pmenu ctermfg=240 ctermbg=255 term=NONE guifg=NONE guibg=#64666d gui=NONE
highlight DiffAdd    cterm=bold ctermfg=2 ctermbg=233 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=2 ctermbg=233 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=2 ctermbg=233 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=2 ctermbg=88  gui=none guifg=bg guibg=Red

" Language specific
autocmd FileType python nmap <buffer> <leader>b :w<CR>:bo term python3 %<CR>
autocmd FileType javascript nmap <buffer> <leader>b :w<CR>:bo term node %<CR>
autocmd FileType cpp nmap <buffer> <leader>b :w<CR>:!clear && g++ % && ./a.out<CR>
autocmd FileType c nmap <buffer> <leader>b :w<CR>:!clear && gcc % && ./a.out<CR>
autocmd FileType rust nmap <buffer> <leader>b :w<CR>:!clear && rustc % -o a.out && ./a.out<CR>
autocmd FileType kotlin nmap <buffer> <leader>b :w<CR>:!clear && kotlinc % -include-runtime -d a.jar && java -jar a.jar<CR>

autocmd BufReadPost *.kt setlocal filetype=kotlin
au! Syntax kotline source ~/.vim/syntax/kotlin

au BufRead,BufNewFile *.aMod set filetype=oberon
au! Syntax oberon source ~/.vim/syntax/oberon2.vim

autocmd FileType cpp setlocal shiftwidth=2 softtabstop=2

" Tmux integration
nnoremap <C-b>s :execute "silent !tmux split-window -v -c \"" . getcwd() . "\""<CR>
nnoremap <C-b>v :execute "silent !tmux split-window -h -c \"" . getcwd() . "\""<CR>

" Pyqo
command! -nargs=1 C :execute 'cd' system('d '.<f-args>.' -e')
cnoreabbrev c C
command! -nargs=1 F :execute 'edit' system('f '.<f-args>.' -e')
cnoreabbrev f F

" Vifm
nnoremap <C-f> :vertical 50 Vifm<CR>
let g:vifm_exec_args = '-c :only'
let g:vifm_embed_split = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" FZF
nnoremap <C-s> :Rg<Space>
nnoremap <C-t> :Files<CR>
nnoremap <C-w><C-w> :History<CR>

command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
    \ {'source': '$FZF_ALT_C_COMMAND',
    \ 'sink': 'cd'}))

if !has('nvim')
    execute "set <M-c>=\ec"
endif
nnoremap <M-c> :Cd<CR>

" EasyMotion
let g:EasyMotion_do_mapping = 0
nmap <Space> <Plug>(easymotion-bd-fn)
vmap <Space> <Plug>(easymotion-bd-tn)
omap <Space> <Plug>(easymotion-bd-tn)

" Tig
command! Blame :execute "!tig blame +" . line(".") . " %"
command! Diffs :!tig status
command! Diff :!git difftool --tool=vimdiff --no-prompt %
command! Log :!tig %
command! Logs :!tig

" Plugins
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vifm/vifm.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
