source ~/.vim/plugins.vim
source ~/.vim/style.vim
source ~/.vim/languages.vim

" Standard
set encoding=UTF-8 ffs=unix,dos,mac
set nobackup nowritebackup noswapfile undofile
set expandtab smarttab shiftwidth=2 tabstop=2 autoindent smartindent
set number relativenumber
set hidden wildmenu lazyredraw list noreadonly equalalways cursorline
set scrolloff=4 mouse=a diffopt+=vertical updatetime=300 shortmess+=aoOtI signcolumn=no
let &undodir=expand('$HOME/.vim/undodir')

" Easy life
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")|exe "norm g'\""|endif
au VimEnter * if &diff|exe 'norm 1G]c[czz'|exe 'windo set nofen fdc=0'|exe 'nm <C-Q> :qa<CR>'|endif
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l
nnoremap ' `
nnoremap + ]czz
nnoremap - [czz
nnoremap <BS> :nohl<CR>
nnoremap <C-Q> ZQ
nnoremap <C-R> :e!<CR>
nnoremap S f,a<CR><Esc>
nnoremap U <C-R>
nnoremap V ggVG
nnoremap vv V
nnoremap à @q
xnoremap à :norm! @q<CR>
nmap s ys
vmap s S
nmap ç #NCgn
vmap ç #Cgn
nmap Ç #NCgN
vmap Ç #CgN

" Clipboard preferences
set clipboard^=unnamed,unnamedplus
inoremap <C-V> <C-R>+
cnoremap <C-V> <C-R>+
nnoremap D "_d
xnoremap D "_d
nnoremap DD "_dd
nnoremap C "_c
xnoremap C "_c
nnoremap CC "_cc
nnoremap X "_x
xnoremap P "_c<C-R>+<Esc>

" Search
set incsearch smartcase ignorecase nomagic
map L /\V\C\<
map H ?\V\C\<
vnoremap * "xy/\V<C-R>x<CR>N
vnoremap # "xy?\V<C-R>x<CR>N
nnoremap ]x /\v^[\=<>\|]{7}[ \n]<CR>
nnoremap [x ?\v^[\=<>\|]{7}[ \n]<CR>

" Shortcuts
nnoremap <C-f> :exe 'FloatermNew --title=Vifm vifm -c :only "%:p:h" .'<CR>
nnoremap <C-n> :CocList -I symbols<CR>
nnoremap <C-p> :History<CR>
nnoremap <C-s> :CtrlSF<Space>
nnoremap <C-t> :Files<CR>
nnoremap <silent> ( :BufferPrevious<CR>
nnoremap <silent> ) :BufferNext<CR>
nnoremap <silent> _ :BufferClose<CR>
nnoremap <silent>   :BufferMovePrevious<CR>
nnoremap <silent> ° :BufferMoveNext<CR>
nmap ù <Plug>(emmet-expand-abbr)

" Git
let floaterm_full='FloatermNew --height=&lines+1 --width=&columns+2'
nnoremap <silent> <leader>b :exe floaterm_full." tig blame +".line(".")." %"<CR>
nnoremap <silent> <leader>l :exe floaterm_full." tig --follow %"<CR>
nnoremap <silent> <leader>L :exe floaterm_full." tig"<CR>
nnoremap <silent> <leader>d :exe floaterm_full." git difftool --no-prompt %"<CR>
nnoremap <silent> <leader>D :exe floaterm_full." tig status"<CR>

" Coc shortcuts
inoremap <expr> <CR> pumvisible()?coc#_select_confirm():"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr> <Tab> match(getline('.'),'\S')>-1&&match(getline('.'),'\S')+1<col('.')
      \ ?coc#refresh():"\<Tab>"
nmap <leader>r <Plug>(coc-rename)
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>a <Plug>(coc-codeaction-cursor)
nmap <leader>i :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" Secondary shortcuts
imap <silent><script><expr> <S-Tab> copilot#Accept("\<CR>")
nmap <leader>s :%s/\s\+$//e<CR>
nmap <leader>t :Vista show<CR>
nmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)

" Term
autocmd TermEnter * nnoremap <buffer> <CR> i
tmap <C-A> <C-\><C-N>
nmap <silent> è :let CP=fnamemodify(expand("%"), ":~:.")
    \ <Bar> exec ':w! <Bar> :FloatermNew --autoclose=0 --title=Zsh  zsh -ic "run '.CP.'"'<CR>

" Tmux integration
nnoremap <C-b>s :exe "silent !tmux split-window -v -c \"" . getcwd() . "\""<CR>
nnoremap <C-b>v :exe "silent !tmux split-window -h -c \"" . getcwd() . "\""<CR>

" Commands
com -nargs=1 EF :exe 'edit '.system('set '.<f-args>.' && echo $(eval $PYQO_F_TARGET)')
com -nargs=+ CHT :exe 'FloatermNew --title=Cht zsh -ic "cht '.&filetype.' '.join([<f-args>],' ').'"'
cnoreabbrev ef EF
cnoreabbrev cht CHT
