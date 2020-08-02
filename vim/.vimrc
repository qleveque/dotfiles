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
" => Coc plugin
""""""""""""""""""""""""""""""
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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

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
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)j
omap if <Plug>(coc-funcobj-i)j
xmap af <Plug>(coc-funcobj-a)j
omap af <Plug>(coc-funcobj-a)j
xmap ic <Plug>(coc-classobj-i)j
omap ic <Plug>(coc-classobj-i)j
xmap ac <Plug>(coc-classobj-a)j
omap ac <Plug>(coc-classobj-a)j

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying codeAction to the current buffer.
nmap <leader>a  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

""""""""""""""""""""""""""""""
" => Fugitive
""""""""""""""""""""""""""""""
command! Diffs :Git difftool -y
command! Diff :Gdiff
command! Commit :BCommits

""""""""""""""""""""""""""""""
" => Shortcuts
""""""""""""""""""""""""""""""
nnoremap <C-f> :Rg 

