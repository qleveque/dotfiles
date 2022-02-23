source ~/.vim/plugins.vim
source ~/.vim/style.vim
source ~/.vim/languages.vim

set clipboard^=unnamed,unnamedplus udir=~/.vim_undo dip+=vertical enc=UTF8
set lz list cul noswf udf si et sts=2 sw=2 ts=2 shm+=aoOtI mouse=a nomagic
set ignorecase smartcase incsearch number relativenumber scrolloff=4

" Easy life
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
vnoremap . :normal .<CR>
inoremap <C-V> <C-R>+
cnoremap <C-V> <C-R>+
noremap D "_d
noremap C "_c
nnoremap DD "_dd
nnoremap CC "_cc
nnoremap X "_x
xnoremap P "_c<C-R>+<Esc>
vnoremap * "xy/\V<C-R>x<CR>
vnoremap # "xy?\V<C-R>x<CR>
nnoremap ]x /\v^[\=<>\|]{7}[ \n]<CR>
nnoremap [x ?\v^[\=<>\|]{7}[ \n]<CR>
map ç #NCgn
map Ç #NCgN
map L /\V\C\<
map H ?\V\C\<

" Shortcuts
nnoremap <C-f> :exe 'FloatermNew --title=Vifm vifm -c :only "%:p:h" .'<CR>
nnoremap <C-n> :CocList -I symbols<CR>
nnoremap <C-p> :History<CR>
nnoremap <C-s> :CtrlSF<Space>
nnoremap <C-t> :Files<CR>

" Secondary shortcuts
nmap s ys
nmap ss yss
vmap s S
nmap <leader>s :%s/\s\+$//e<CR>
imap <silent><script><expr> <S-Tab> copilot#Accept("\<CR>")
nmap ù <Plug>(emmet-expand-abbr)
nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>i :call CocAction('runCommand','editor.action.organizeImport')<CR>
inor <expr> <Tab> col('.')-1&&getline('.')[col('.')-2]!~#'\s'?coc#refresh():tab
inoremap <expr> <CR> pumvisible()?coc#_select_confirm():"\<CR>"

" Buffers
nnoremap <silent> ( :BufferPrevious<CR>
nnoremap <silent> ) :BufferNext<CR>
nnoremap <silent> _ :BufferClose<CR>
nnoremap <silent>   :BufferMovePrevious<CR>
nnoremap <silent> ° :BufferMoveNext<CR>

" Git
au VimEnter * if &diff|exe 'norm 1G+-'|exe 'windo set wrap nofen fdc=0'|endif
nnoremap <silent> <leader>b :exe floaterm_full." tig blame +".line(".")." %"<CR>
nnoremap <silent> <leader>l :exe floaterm_full." tig --follow %"<CR>
nnoremap <silent> <leader>L :exe floaterm_full." tig"<CR>
nnoremap <silent> <leader>d :exe floaterm_full." git difftool --no-prompt %"<CR>
nnoremap <silent> <leader>D :exe floaterm_full." tig status"<CR>

" Term
autocmd TermEnter * nnoremap <buffer> <CR> i
tnoremap <C-A> <C-\><C-N>
nnoremap <silent> <C-W><C-W> :FloatermToggle<CR>
tnoremap <silent> <C-W><C-W> <C-\><C-n>:FloatermToggle<CR>
nnoremap <silent> é :exe run.' "run '.expand("%").'"'<CR>
nnoremap <C-b>s :exe "silent !tmux split-window -v -c \"".getcwd()."\""<CR>
nnoremap <C-b>v :exe "silent !tmux split-window -h -c \"".getcwd()."\""<CR>
cabbrev ef EF|com -nargs=1 EF :exe 'e '.system('set '.<f-args>.'&&'.pyqo_f)
