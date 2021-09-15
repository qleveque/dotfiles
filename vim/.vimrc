" Plugins
call plug#begin('~/.vim/plugged')
Plug 'ap/vim-css-color'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'gcavallanti/vim-noscrollbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vista.vim'
Plug 'mattn/emmet-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'udalov/kotlin-vim'
Plug 'vifm/vifm.vim'
Plug 'vim-scripts/argtextobj.vim'
Plug 'yggdroot/indentLine'
call plug#end()

" Language specific
source ~/.vim/languages.vim

" Style
source ~/.vim/style.vim

" Standard
set encoding=UTF-8 ffs=unix,dos,mac
set nobackup nowritebackup noswapfile
set number relativenumber
set expandtab smarttab shiftwidth=4 tabstop=4 ai si wrap
set hidden wildmenu lazyredraw list noro noequalalways nomagic gdefault
set so=4 mouse=a showbreak= diffopt+=vertical updatetime=300
set shortmess+=aoOtI
set undodir=~/.vim/undodir
set undofile
set signcolumn=no
" set signcolumn=number

" Easy life
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
noremap <C-Y> 5<C-Y>
noremap <C-E> 5<C-E>
nnoremap <C-W>t :tabnew<CR>
nnoremap <C-W>n :bn<CR>
nnoremap <C-W>p :bp<CR>
nnoremap <C-W><C-W> :e#<CR>
nnoremap <C-Q> :q<CR>
nmap s ys
vmap s S
nnoremap S f,a<CR><Esc>
nnoremap vv V
nnoremap V ggVG
nnoremap ' `
nnoremap à @q
xnoremap à :norm! @q<CR>
nnoremap U <C-R>
nnoremap <C-R> :e!<CR>
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

" More text objects
for s:char in [ '_', '-', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '$' ]
  execute 'xnoremap i' . s:char . ' :<C-u>normal! T' . s:char . 'vt' . s:char . '<CR>'
  execute 'onoremap i' . s:char . ' :normal vi' . s:char . '<CR>'
  execute 'xnoremap a' . s:char . ' :<C-u>normal! F' . s:char . 'vt' . s:char . '<CR>'
  execute 'onoremap a' . s:char . ' :normal va' . s:char . '<CR>'
endfor

" Search
set incsearch nohlsearch smartcase ignorecase
vnoremap * "xy/\V<C-R>x<CR>N
vnoremap # "xy?\V<C-R>x<CR>N
nnoremap ]x /\v[(<{7})(>{7})(\|{7})(\={7})][ \n]<CR>
nnoremap [x ?\v[(<{7})(>{7})(\|{7})(\={7})][ \n]<CR>

" Shortcuts
nnoremap <C-s> :Rg<Space>
nnoremap <C-n> :CocList -I symbols<CR>
nnoremap <C-f> :vert 50 Vifm %:p:h .<CR>
nnoremap <C-t> :Files<CR>
nnoremap <C-p> :History<CR>

nmap <Space> <Plug>(easymotion-bd-f2)
vmap <Space> <Plug>(easymotion-bd-t2)
omap <Space> <Plug>(easymotion-bd-t2)

" Git
nnoremap <leader>b :execute "term tig blame +" . line(".") . " %" <Bar> exec ':norm! i'<CR>
nnoremap <leader>l :execute "term tig %" <Bar> exec ':norm! i'<CR>
nnoremap <leader>L :execute "term tig" <Bar> exec ':norm! i'<CR>
nnoremap <leader>d :execute "term git difftool --no-prompt %" <Bar> exec ':norm! i'<CR>
nnoremap <leader>D :execute "term tig status" <Bar> exec ':norm! i'<CR>
nnoremap <leader>m :execute "term git mergetool --no-prompt" <Bar> exec ':norm! i'<CR>

" Term
tmap <C-a> <C-\><C-n>
autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no noshowmode noshowcmd
autocmd TermClose * call feedkeys("<CR>")

" Coc
let g:coc_disable_startup_warning = 1
autocmd CursorHold * silent call CocActionAsync('highlight')
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <leader>r <Plug>(coc-rename)
nmap <leader>i :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
xmap <leader>f <Plug>(coc-format-selected)
nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
nnoremap K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
nmap <leader>f vv<leader>f

" Vista
nnoremap <leader>t :Vista show<CR>

" Spaces
autocmd BufWritePre * :%s/\s\+$//e
map ga <Plug>(EasyAlign)

" Emmet
let g:user_emmet_leader_key='<C-Z>'
imap <S-tab> <C-Z>,

" Tmux integration
nnoremap <C-b>s :execute "silent !tmux split-window -v -c \"" . getcwd() . "\""<CR>
nnoremap <C-b>v :execute "silent !tmux split-window -h -c \"" . getcwd() . "\""<CR>

" Pyqo
command! -nargs=1 C :execute 'cd' system('d '.<f-args>.' -e')
cnoreabbrev c C
command! -nargs=1 F :execute 'edit' system('f '.<f-args>.' -e')
cnoreabbrev f F

" Vimspector
nmap è :w!
    \ <Bar> let CP=fnamemodify(expand("%"), ":~:.")
    \ <Bar> bo 15 new
    \ <Bar> exec ':term zsh -ic "{run '.CP.'} always {read _\?\"[Done...]\"}"'
    \ <Bar> redraw
    \ <Bar> exec ':norm! i'<CR>
nmap éé <Plug>VimspectorContinue
nmap ér <Plug>VimspectorContinue
nmap él <Plug>VimspectorStepInto
nmap éh <Plug>VimspectorStepOut
nmap éj <Plug>VimspectorStepOver
nmap éb <Plug>VimspectorToggleBreakpoint
nmap éc <Plug>VimspectorRunToCursor
nmap én <Plug>VimspectorUpFrame
nmap ép <Plug>VimspectorDownFrame
nmap ék :VimspectorReset<CR>
nmap éw :VimspectorWatch<Space>
vmap éw "xy:VimspectorWatch <C-R>+<CR>
nmap és <Plug>VimspectorBalloonEval
xmap és <Plug>VimspectorBalloonEval

" Plugin specific
let g:vifm_exec_args = '-c :only'
let g:vifm_embed_split = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:vifm_replace_netrw = 1
let g:vista_default_executive = 'coc'
let g:vista_close_on_jump = 1
let g:vista_ignore_kinds = ['Variable']
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
