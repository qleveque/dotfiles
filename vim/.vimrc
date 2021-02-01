" basic.vim
source ~/.vim/basic.vim
mapclear
let mapleader = "\\"
set stal=1
set statusline=\ %<%F\ (%{&ff})%m%=%5l/%L%4v\ "
set magic!

" coc.vim
source ~/.vim/coc.vim
let g:coc_disable_startup_warning = 1
nnoremap <leader>i :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
nnoremap <leader>f :call CocAction('format')<CR>
if !has('nvim')
    execute "set <M-CR>=\<esc>\<cr>"
endif
nmap <M-CR> :CocFix<CR>
inoremap <silent><expr> <Enter> pumvisible() ? coc#_select_confirm() : "<CR>"
command! CocMarket :execute "CocList marketplace"

" Miscellaneous
set cursorline
set mouse=a
set showbreak=►►►
set shortmess+=I
set diffopt+=vertical
set number relativenumber
set noro
nnoremap <C-q> :q<CR>
xnoremap @ :norm! @

" Clipboard preferences
set clipboard^=unnamed,unnamedplus
inoremap <C-V> <C-R>"

nnoremap DD "_dd
nnoremap D "_d
xnoremap D "_d
nnoremap cc "_cc
nnoremap c "_c
xnoremap c "_c
xnoremap CC cc
nnoremap C c
xnoremap C c
nnoremap x "_x
nnoremap X x
xnoremap p pgvy
xnoremap P p

" Search
nnoremap <BackSpace> :nohl<cr>
vnoremap / "xy/<C-R>x<CR>N
vnoremap ? "xy?<C-R>x<CR>N
nnoremap // /<C-R>"<CR>
nnoremap ?? ?<C-R>"<CR>

" Trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()
nnoremap <leader>s :call CleanExtraSpaces()<CR>

" Persistent undo
set undodir=~/.vim/undodir
set undofile

" Term
if has("nvim")
    tmap <C-a> <C-\><C-n>
    nnoremap <F9> :w! <Bar> let CP=expand('%:p') <Bar> bo 15 new <Bar> exec ':term zsh -ic "{run \"'.CP.'\"} always {read _\?\"[Done...]\"}"'<CR>

    autocmd TermOpen * startinsert
    autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no noshowmode noshowcmd noruler laststatus=0 noshowcmd cmdheight=1
    autocmd TermClose * setlocal number relativenumber signcolumn=yes showmode showcmd ruler laststatus=2 noshowcmd cmdheight=2
    autocmd TermClose * call feedkeys("<CR>")
endif

" Style
highlight Pmenu ctermfg=240 ctermbg=255 term=NONE guifg=NONE guibg=#64666d gui=NONE
highlight DiffAdd    cterm=bold ctermfg=2 ctermbg=233 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=2 ctermbg=233 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=2 ctermbg=233 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=2 ctermbg=88  gui=none guifg=bg guibg=Red

" Language specific
autocmd FileType cpp setlocal shiftwidth=2 softtabstop=2

autocmd BufReadPost *.kt setlocal filetype=kotlin
au! Syntax kotline source ~/.vim/syntax/kotlin
au BufRead,BufNewFile *.aMod set filetype=oberon
au! Syntax oberon source ~/.vim/syntax/oberon2.vim

" Tmux integration
nnoremap <C-b>s :execute "silent !tmux split-window -v -c \"" . getcwd() . "\""<CR>
nnoremap <C-b>v :execute "silent !tmux split-window -h -c \"" . getcwd() . "\""<CR>

" Pyqo
command! -nargs=1 C :execute 'cd' system('d '.<f-args>.' -e')
cnoreabbrev c C
command! -nargs=1 F :execute 'edit' system('f '.<f-args>.' -e')
cnoreabbrev f F

" Vifm
nnoremap <C-f> :vert 50 Vifm<CR>
let g:vifm_exec_args = '-c :only'
let g:vifm_embed_split = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" FZF
nnoremap <C-s> :Rg<Space>
nnoremap <C-t> :Files<CR>
nnoremap <C-w><C-w> :History<CR>

if !has('nvim')
    execute "set <M-c>=\ec"
endif
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap({'source': '$FZF_ALT_C_COMMAND', 'sink': 'cd'}))
nnoremap <M-c> :Cd<CR>

" EasyMotion
let g:EasyMotion_do_mapping = 0
nmap <silent><nowait> <Space> <Plug>(easymotion-bd-fn)
vmap <silent><nowait> <Space> <Plug>(easymotion-bd-tn)
omap <silent><nowait> <Space> <Plug>(easymotion-bd-tn)

" Git
command! Blame :execute "term tig blame +" . line(".") . " %"
command! Diffs :term tig status
command! Log :term tig %
command! Diff :term git difftool --no-prompt %
command! Logs :term tig

" Align
map ga <Plug>(EasyAlign)

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vifm/vifm.vim'
call plug#end()
