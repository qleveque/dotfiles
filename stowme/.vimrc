set cb^=unnamed,unnamedplus sd=!,'1000,<50,s10,h stl=%1*\ \%f%m\ %0*%= mousescroll=ver:1
set so=4 hls ic scs is nu lz list noswf udf et cul tgc ch=0 dip+=vertical shm+=aI

" Easy life
nn ' `
nn <BS> :nohl<CR>
nn <C-Q> ZQ
nn S f,a<CR><Esc>
nn à @q
no D "_d
no C "_c
nn DD "_dd
nn CC "_cc
nn X "_x
nn V <C-V>
nn vv V
vno * "xy/<C-R>x<CR>
xno P "_c<C-R>+<Esc>
xno à :norm! @q<CR>
xno . :norm! .<CR>
map ç *Nzzcgn
map Ç *NzzCgn
map L /\C\<
map H ?\C\<
nm s ys
vm s S
vm <C-e> <C-y>,
im <C-e> <C-y>,

" Shortcuts
nn <C-f> :exe 'FloatermNew --title=─ vifm -c :only "%:p:h"'<CR>
nn <C-n> :CocList -I symbols<CR>
nn <C-t> :lua require'telescope.builtin'.find_files()<CR>
nn <C-s> :lua require'telescope.builtin'.live_grep()<CR>
nn <C-p> :lua require'telescope.builtin'.oldfiles()<CR>

" Buffers
nn <silent> ( :BufferPrevious<CR>
nn <silent> ) :BufferNext<CR>
nn <silent> _ :BufferClose<CR>
nn <silent>   :BufferMovePrevious<CR>
nn <silent> ° :BufferMoveNext<CR>

" Coc
nm gd <Plug>(coc-definition)
nm gr <Plug>(coc-references)
xm <leader>f <Plug>(coc-format-selected)
ino <silent><expr> <CR> coc#pum#visible()?coc#pum#confirm():"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
ino <silent><expr> <TAB> coc#pum#visible()?coc#pum#next(1):col('.')-1&&getline('.')[col('.')-2]!~#'\s'?coc#refresh():"\<Tab>"
ino <expr><S-TAB> coc#pum#visible()?coc#pum#prev(1):"\<C-h>"

" Diff
let diffs=['set noro','windo set wrap nofen fdc=0','nm <C-Q> :qa<CR>','map + ]czt','map - [czt','norm 1G+-']
ca diff Diff|com Diff :exe 'windo diffthis|for c in diffs|exe c|endfor'
au VimEnter * if !&diff|exe 'map - :cprev<CR>'|exe 'map + :cnext<CR>'|else|for c in diffs|exe c|endfor|endif

" Term
tno <C-A> <C-\><C-N>
nn <silent> é :exe ':w! \| :FloatermNew --autoclose=0 --title=─ run '.'"'.expand("%").'"'<CR>
nn <silent> <C-W><C-W> :FloatermToggle<CR>
tno <silent> <C-W><C-W> <C-\><C-n>:FloatermToggle<CR>
nn <C-b>s :exe "silent !tmux split-window -v -c \"".getcwd()."\""<CR>
nn <C-b>v :exe "silent !tmux split-window -h -c \"".getcwd()."\""<CR>

" Git
noremap ]x /\v^[\=<>\|]{7}.*<CR>
noremap [x ?\v^[\=<>\|]{7}.*<CR>
nmap dc [xjV]xky?\v\<{7}.*<CR>V/\v\>{7}.*<CR>DP<BS>
let tc="'--title=Git --height=1.0 --width=1.0 cd '.fnamemodify(resolve(expand('%')),':h')"
nn <leader>D :exe "FloatermNew ".eval(tc)."&&tig status"<CR>
nn <leader>L :exe "FloatermNew ".eval(tc)."&&tig"<CR>
nn <leader>b :exe "FloatermNew ".eval(tc)."&&tig blame +".line(".")." ".expand('%:t')<CR>
nn <leader>d :exe "FloatermNew ".eval(tc)."&&git difftool -y ".expand('%:t')<CR>
nn <leader>l :exe "FloatermNew ".eval(tc)."&&tig --follow ".expand('%:t')<CR>

" Style
let RED="IndianRed4"|let GREEN="DarkGreen"|let BLUE="DarkSlateBlue"
for [bg, contexts] in items({
    \"$TMUX_BG":["ActiveWin","FloatermBorder","TelescopeNormal"],
    \"$TMUX_LIGHT_BG":["CursorLine","InactiveWin","VertSplit"],
    \"$TMUX_LIGHTER_BG":["CursorLineNr","PmenuSel","LineNr","BufferTabpageFill","TelescopeSelection"],
    \"$TMUX_LIGHTEST_BG":["Pmenu","User1"],
    \"RED":["ConflictMarkers"],"GREEN":["DiffAdd"],"BLUE":["DiffText","CurSearch"]})
  for context in contexts
    exe 'hi '.context.' gui=none guifg=none guibg='.eval(bg)
  endfor
endfor
for v in ['','Mod','Index','Sign']
  exe 'hi BufferCurrent'.v.' guibg='.eval('$TMUX_BG')
  exe 'hi BufferInactive'.v.' guibg='.eval('$TMUX_LIGHTEST_BG')
  exe 'hi BufferVisible'.v.' guibg='.eval('$TMUX_LIGHTEST_BG')
endfor
exe 'hi Visual guifg=black guibg='.eval('$TMUX_GREY')
exe 'hi StatusLine gui=underline guibg='.eval('$TMUX_BG')
exe 'hi StatusLineNC gui=underline guibg='.eval('$TMUX_LIGHT_BG')
exe 'hi DiffDelete guibg='.eval('RED').' guifg='.eval('RED')
hi CocErrorFloat guifg=orange
hi DiffChange guibg=none
au FocusLost * setlocal winhl=Normal:InactiveWin
au BufEnter,BufRead,BufReadPost * syntax match ConflictMarkers "\v[\<\>\|=]{7}.*"
au BufNew,BufLeave,BufRead,FocusGained * setlocal winhl=Normal:ActiveWin,NormalNC:InactiveWin

" Plugins
call plug#begin('~/.vim_plugged')
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'dstein64/nvim-scrollview'
  Plug 'farmergreg/vim-lastplace'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'mattn/emmet-vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'romgrk/barbar.nvim'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'voldikss/vim-floaterm'
call plug#end()
let g:floaterm_opener='edit'
let g:floaterm_width=0.85
let g:coc_global_extensions=['coc-json','coc-highlight','coc-tsserver','coc-html','coc-css','coc-pyright','coc-clangd']
lua << EOF
  require'bufferline'.setup{exclude_ft={'qf'}}
  require'telescope'.setup{defaults={mappings={
    i={['<ESC>']=require('telescope.actions').close,['<C-V>']={'<C-R>+',type="command"}}
  }}}
EOF
