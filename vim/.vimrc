" Plugins
call plug#begin('~/.vim/plugged')
Plug 'ap/vim-css-color'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dstein64/nvim-scrollview'
Plug 'dyng/ctrlsf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'github/copilot.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'liuchengxu/vista.vim'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
Plug 'romgrk/barbar.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'
Plug 'yggdroot/indentLine'
Plug 'psliwka/vim-smoothie'

Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'udalov/kotlin-vim'
Plug 'posva/vim-vue'
call plug#end()

" Language specific
source ~/.vim/languages.vim

" Style
source ~/.vim/style.vim

" Standard
set encoding=UTF-8 ffs=unix,dos,mac
set nobackup nowritebackup noswapfile
set number relativenumber
set expandtab smarttab shiftwidth=2 tabstop=2 autoindent smartindent
set hidden wildmenu lazyredraw list noro equalalways gdefault
set so=4 mouse=a diffopt+=vertical wrap! updatetime=300
set shortmess+=aoOtI
set signcolumn=number
set undofile
let &undodir=expand('$HOME/.vim/undodir')

" Easy life
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
      \ exe "normal! g'\"" |
      \ endif
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
noremap <C-Y> 5<C-Y>
noremap <C-E> 5<C-E>
nnoremap <C-Q> ZQ
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
nnoremap ! :!
nnoremap <Esc> :nohl<CR>
nnoremap <A-;> :cnext<CR>
nnoremap <A-,> :cprev<CR>

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
vnoremap * "xy/\V<C-R>x<CR>N
vnoremap # "xy?\V<C-R>x<CR>N
nnoremap ]x /\v^[\=<>\|]{7}[ \n]<CR>
nnoremap [x ?\v^[\=<>\|]{7}[ \n]<CR>

" Vimdiff
autocmd VimEnter * if &diff |
  \ execute 'windo set foldcolumn=0 nofoldenable wrap linebreak showbreak=>  ' |
  \ execute 'norm 1G]c[c' |
  \ execute 'nnoremap <C-Q> :qa<CR>' |
  \ endif

" Shortcuts
nnoremap <C-s> :CtrlSF<Space>
nnoremap <C-n> :CocList -I symbols<CR>
nnoremap <silent> <C-f> :execute 'FloatermNew --title=Vifm vifm -c :only "%:p:h" .'<CR>
nnoremap <C-t> :Files<CR>
nnoremap <C-p> :History<CR>

nmap <Space> <Plug>(easymotion-bd-f2)
vmap <Space> <Plug>(easymotion-bd-t2)
omap <Space> <Plug>(easymotion-bd-t2)

" Term
autocmd TermEnter * nnoremap <buffer> <CR> i
autocmd TermEnter * tnoremap <buffer> <C-W><C-W> <C-\><C-N>:FloatermToggle<CR>
tmap <C-A> <C-\><C-N>
nnoremap <C-W><C-W> :FloatermToggle<CR>

" Git
let floaterm_full='FloatermNew --height=&lines+1 --width=&columns+2'
nnoremap <silent> <leader>b :execute floaterm_full." tig blame +".line(".")." %"<CR>
nnoremap <silent> <leader>l :execute floaterm_full." tig %"<CR>
nnoremap <silent> <leader>L :execute floaterm_full." tig"<CR>
nnoremap <silent> <leader>d :execute floaterm_full." git difftool --no-prompt %"<CR>
nnoremap <silent> <leader>D :execute floaterm_full." tig status"<CR>
nnoremap <silent> <leader>m :execute floaterm_full." git mergetool --no-prompt"<CR>

" Cht
command! -nargs=+ CHT :execute 'FloatermNew --title=Cht.sh '
    \.'zsh -ic "cht '.&filetype.' '.join([<f-args>],' ').'"'
cnoreabbrev cht CHT

" Coc
let g:coc_disable_startup_warning = 1
map <leader><leader> <Plug>(coc-codeaction-cursor)
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <leader>r <Plug>(coc-rename)
nmap <leader>i :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>a <Plug>(coc-codeaction-cursor)
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
let g:vista_default_executive = 'coc'
let g:vista_close_on_jump = 1
let g:vista_ignore_kinds = ['Variable']

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
command! -nargs=1 EF :execute 'edit '
      \ .system('set '.<f-args>.' && echo $(eval $PYQO_F_TARGET)')
cnoreabbrev ef EF

" Vimspector
nmap <silent> è :w!
    \ <Bar> let CP=fnamemodify(expand("%"), ":~:.")
    \ <Bar> exec ':FloatermNew --autoclose=0 --title=Zsh  zsh -ic "run '.CP.'"'<CR>
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

" Vifm
let g:vifm_exec_args = '-c :only'
let g:vifm_embed_split = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:vifm_replace_netrw = 1

" Floaterm
let g:floaterm_opener='edit'
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_autoclose=2

" Barbar
nnoremap <silent> <Left> :BufferPrevious<CR>
nnoremap <silent> <Right> :BufferNext<CR>
nnoremap <silent> <S-Left> :BufferMovePrevious<CR>
nnoremap <silent> <S-Right> :BufferMoveNext<CR>
nnoremap <silent> <Down> :BufferClose<CR>
nnoremap <silent> <Up> :enew<CR>
let bufferline = get(g:, 'bufferline', {})
let bufferline.icons = v:true
let bufferline.closable = v:true
let bufferline.icon_custom_colors = v:true
let bufferline.auto_hide = v:true

" Copilot
imap <silent><script><expr> <S-Tab> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Plugin specific
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:ctrlsf_mapping = {"openb": "<Enter>", "next": "n", "prev": "N"}
let g:smoothie_speed_linear_factor = 30
