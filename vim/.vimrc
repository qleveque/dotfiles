source ~/.vimrc_base

""""""""""""""""""""""""""""""
" => Miscellaneous
""""""""""""""""""""""""""""""
set wrap
set linebreak
set showbreak=>\ \ \
tnoremap <c-x> <c-\><c-n>
autocmd BufWritePre * %s/\s\+$//e
set shortmess=I
set cmdheight=2

""""""""""""""""""""""""""""""
" => Execute
""""""""""""""""""""""""""""""
autocmd FileType python nmap <buffer> <leader>b :w<CR>:bo term python3 %<CR>
autocmd FileType javascript nmap <buffer> <leader>b :w<CR>:bo term node %<CR>
autocmd FileType cpp nmap <buffer> <leader>b :w<CR>:!clear && g++ % && ./a.out<CR>
autocmd FileType c nmap <buffer> <leader>b :w<CR>:!clear && gcc % && ./a.out<CR>
autocmd FileType rust nmap <buffer> <leader>b :w<CR>:!clear && rustc % -o a.out && ./a.out<CR>
autocmd FileType kotlin nmap <buffer> <leader>b :w<CR>:!clear && kotlinc % -include-runtime -d a.jar && java -jar a.jar<CR>
set termwinsize=15x0

""""""""""""""""""""""""""""""
" => Tmux integration
""""""""""""""""""""""""""""""
nnoremap <C-b>s :execute "silent !tmux split-window -v -c \"" . getcwd() . "\""<CR>
nnoremap <C-b>v :execute "silent !tmux split-window -h -c \"" . getcwd() . "\""<CR>

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
" => Style
""""""""""""""""""""""""""""""
highlight Pmenu ctermfg=240 ctermbg=255 term=NONE guifg=NONE guibg=#64666d gui=NONE
highlight DiffAdd    cterm=bold ctermfg=2 ctermbg=233 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=2 ctermbg=233 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=2 ctermbg=233 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=2 ctermbg=88  gui=none guifg=bg guibg=Red

""""""""""""""""""""""""""""""
" => Oberon
""""""""""""""""""""""""""""""
autocmd BufReadPost *.kt setlocal filetype=kotlin
au! Syntax kotline source ~/.vim/syntax/kotlin
au BufRead,BufNewFile *.aMod set filetype=oberon
au! Syntax oberon source ~/.vim/syntax/oberon2.vim

""""""""""""""""""""""""""""""
" => Pyqo
""""""""""""""""""""""""""""""
command! -nargs=1 C :execute 'cd' system('d '.<f-args>.' -e')
cnoreabbrev c C
command! -nargs=1 F :execute 'edit' system('f '.<f-args>.' -e')
cnoreabbrev f F

""""""""""""""""""""""""""""""
" => Vim tree
""""""""""""""""""""""""""""""
let g:vifm_exec_args = '-c :only'
let g:vifm_embed_split = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""
" => FZF
""""""""""""""""""""""""""""""
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
    \ {'source': '$FZF_ALT_C_COMMAND',
    \ 'sink': 'cd'}))

if !has('nvim')
    execute "set <M-c>=\ec"
endif
nnoremap <M-c> :Cd<CR>

""""""""""""""""""""""""""""""
" => EasyMotion
""""""""""""""""""""""""""""""
let g:EasyMotion_do_mapping = 0
nmap <Space> <Plug>(easymotion-bd-fn)
vmap <Space> <Plug>(easymotion-bd-tn)
omap <Space> <Plug>(easymotion-bd-tn)

""""""""""""""""""""""""""""""
" => Tig
""""""""""""""""""""""""""""""
command! Blame :execute "!tig blame +" . line(".") . " %"
command! Diffs :!tig status
command! Diff :!git difftool --tool=vimdiff --no-prompt %
command! Log :!tig %
command! Logs :!tig

""""""""""""""""""""""""""""""
" => Shortcuts
""""""""""""""""""""""""""""""
nnoremap <C-s> :Rg<Space>
nnoremap <C-t> :Files<CR>
nmap <C-f> :vertical 50 Vifm<CR>
nnoremap <C-w><C-w> :History<CR>

""""""""""""""""""""""""""""""
" => Coc plugin
""""""""""""""""""""""""""""""
command! CocMarket :execute "CocList marketplace"

let g:coc_disable_startup_warning = 1

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Organize imports of the current buffer.
nnoremap <leader>i :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" Format current buffer.
nnoremap <leader>f :call CocAction('format')<CR>

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Code action
if !has('nvim')
    execute "set <M-CR>=\<esc>\<cr>"
endif
nmap <M-CR> :CocFix<CR>

" Validate auto-completion
inoremap <silent><expr> <Enter> pumvisible() ? coc#_select_confirm() : "<CR>"

