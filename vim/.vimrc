source ~/.vim/plugins.vim
source ~/.vim/style.vim
source ~/.vim/languages.vim

set enc=UTF-8 udir=~/.vim_undo dip+=vertical cb^=unnamed,unnamedplus mouse=a
set lz list cul noswf nu rnu udf et si is scs nomagic sts=2 sw=2 ts=2 so=4

" Easy life
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
map ç #NCgn
map Ç #NCgN
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
map L /\V\C\<
map H ?\V\C\<
nmap <leader>s :%s/\s\+$//e<CR>

" Shortcuts
nnoremap <C-f> :exe 'FloatermNew --title=Vifm vifm -c :only "%:p:h" .'<CR>
nnoremap <C-n> :CocList -I symbols<CR>
nnoremap <C-p> :History<CR>
nnoremap <C-s> :CtrlSF<Space>
nnoremap <C-t> :Files<CR>

" Secondary shortcuts
inoremap <expr> <CR> pumvisible()?coc#_select_confirm():
  \ "\<C-G>u\<CR>\<C-R>=coc#on_enter()\<CR>"
inoremap <expr> <Tab> <SID>check_back_space() ? coc#refresh():"\<Tab>"
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>i :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)
nmap ù <Plug>(emmet-expand-abbr)
imap <silent><script><expr> <S-Tab> copilot#Accept("\<CR>")
function! s:check_back_space() abort
  return !col('.')-1||getline('.')[col('.')-2]=~#'\s'
endfunction

" Buffers
nnoremap <silent> ( :BufferPrevious<CR>
nnoremap <silent> ) :BufferNext<CR>
nnoremap <silent> _ :BufferClose<CR>
nnoremap <silent>   :BufferMovePrevious<CR>
nnoremap <silent> ° :BufferMoveNext<CR>

" Git
au VimEnter * if &diff|exe 'norm 1G+-'|exe 'windo set wrap nofen fdc=0'|endif
let floaterm_full='FloatermNew --height=&lines+1 --width=&columns+2 '
nnoremap <silent> <leader>b :exe floaterm_full."tig blame +".line(".")." %"<CR>
nnoremap <silent> <leader>l :exe floaterm_full."tig --follow %"<CR>
nnoremap <silent> <leader>L :exe floaterm_full."tig"<CR>
nnoremap <silent> <leader>d :exe floaterm_full."git difftool --no-prompt %"<CR>
nnoremap <silent> <leader>D :exe floaterm_full."tig status"<CR>

" Term
autocmd TermEnter * nnoremap <buffer> <CR> i
tmap <C-A> <C-\><C-N>
nmap <silent> è :let CP=fnamemodify(expand("%"), ":~:.") <Bar> exec ':w!
  \ <Bar> :FloatermNew --autoclose=0 --title=Zsh zsh -ic "run '.CP.'"'<CR>
nnoremap <C-b>s :exe "silent !tmux split-window -v -c \"" . getcwd() . "\""<CR>
nnoremap <C-b>v :exe "silent !tmux split-window -h -c \"" . getcwd() . "\""<CR>
com -nargs=1 EF :exe 'e '.system('set '.<f-args>.'&&echo `eval $PYQO_F_TARGET`')
cnoreabbrev ef EF
