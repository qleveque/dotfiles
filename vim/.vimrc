" coc.vim
source ~/.vim/coc.vim
let g:coc_disable_startup_warning = 1
nnoremap <leader>i :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
nnoremap <leader>f :call CocAction('format')<CR>
nmap <M-CR> :CocFix<CR>
set statusline=\ %F%m\ %=%v\ %{noscrollbar#statusline()}\ "
set cmdheight=1

" Plugins
source ~/.vim/plugins.vim

" Language specific
source ~/.vim/languages.vim

" Colors
set t_Co=256
colorscheme desert
set background=dark
highlight LineNr ctermfg=grey
highlight TabLine ctermfg=black ctermbg=grey
highlight CocErrorFloat ctermfg=black
highlight CocWarningFloat ctermfg=yellow
highlight DiffAdd cterm=BOLD ctermfg=253 ctermbg=22
highlight DiffDelete cterm=BOLD ctermfg=52 ctermbg=52
highlight DiffChange cterm=BOLD ctermfg=253 ctermbg=23
highlight DiffText cterm=BOLD ctermfg=253 ctermbg=9

" Standard
set encoding=utf8
set ffs=unix,dos,mac
set so=4
set hidden
set wildmenu
set ignorecase smartcase
set lazyredraw
set nobackup nowb noswapfile
set expandtab smarttab shiftwidth=4 tabstop=4
set ai si wrap
set cursorline
set mouse=a
set showbreak=►►►
set shortmess+=aoOtI
set diffopt+=vertical
set number relativenumber
set noro
set list
set noequalalways
set nomagic
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Easy life
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
nnoremap <C-w>t :tabnew<CR>
nnoremap <C-w><C-w> :e#<CR>
nnoremap <C-q> :q<CR>
nnoremap à @q
xnoremap à :norm! @q<CR>
nmap s ys
vmap s S
nmap µ *#cgn
vmap µ *cgn
vnoremap v V
nnoremap V ggVG
nnoremap Y ggVGy
nnoremap ' `

" Clipboard preferences
set clipboard^=unnamed,unnamedplus
inoremap <C-V> <C-R>+
nnoremap D "_d
xnoremap D "_d
nnoremap DD "_dd
nnoremap C c
xnoremap C c
nnoremap CC cc
nnoremap c "_c
xnoremap c "_c
nnoremap cc "_cc
nnoremap x "_x
nnoremap X x
xnoremap p "_c<C-R>+<Esc>
xnoremap P p

" Search
set incsearch nohlsearch
vnoremap * "xy/\V<C-R>x<CR>N
vnoremap # "xy?\V<C-R>x<CR>N
nnoremap // /\V<C-R>+<CR>
nnoremap ?? ?\V<C-R>+<CR>
nnoremap ]x /\v^[<>\|=]{7}[ \n]<CR>
nnoremap [x ?\v^[<>\|=]{7}[ \n]<CR>

" Persistent undo
set undodir=~/.vim/undodir
set undofile

" Shortcuts
nnoremap <C-s> :CocSearch<Space>
nnoremap <C-n> :CocList -I symbols<CR>
nnoremap <C-f> :vert 50 Vifm %:p:h .<CR>
nnoremap <C-t> :Files<CR>
nnoremap <C-p> :History<CR>

nmap <Space> <Plug>(easymotion-bd-f2)
vmap <Space> <Plug>(easymotion-bd-t2)
omap <Space> <Plug>(easymotion-bd-t2)

" Git
command! Blame :execute "term tig blame +" . line(".") . " %"
command! Logs :term tig
command! Log :term tig %
command! Diffs :term tig status
command! Diff :term git difftool --no-prompt %
command! Merge :term git mergetool --no-prompt

" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" Vifm
let g:vifm_exec_args = '-c :only'
let g:vifm_embed_split = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:vifm_replace_netrw = 1

" Vista
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 0
let g:vista_close_on_jump = 1
let g:vista_ignore_kinds = ['Variable']
nnoremap <leader>t :Vista show<CR>

" Spaces
nnoremap <leader>s :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>nohl<CR>
map ga <Plug>(EasyAlign)

" Emmet
imap <S-tab> <C-y>,

" Tmux integration
nnoremap <C-b>s :execute "silent !tmux split-window -v -c \"" . getcwd() . "\""<CR>
nnoremap <C-b>v :execute "silent !tmux split-window -h -c \"" . getcwd() . "\""<CR>

" Pyqo
command! -nargs=1 C :execute 'cd' system('d '.<f-args>.' -e')
cnoreabbrev c C
command! -nargs=1 F :execute 'edit' system('f '.<f-args>.' -e')
cnoreabbrev f F

" Term
if has("nvim")
    tmap <C-a> <C-\><C-n>
    nnoremap <F9> :w! <Bar> let CP=expand('%:p') <Bar> bo 15 new <Bar> exec ':term zsh -ic "{run \"'.CP.'\"} always {read _\?\"[Done...]\"}"'<CR>
    autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no noshowmode noshowcmd
    autocmd TermOpen * startinsert
    autocmd TermClose * call feedkeys("<CR>")
endif

" Diff
if &diff
    set scl=no
endif

