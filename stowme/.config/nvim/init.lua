local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.cmd('source ~/.vimrc')

require("lazy").setup({
  {
    "neoclide/coc.nvim",
    branch = "release",
    init = function()
      vim.cmd[[
        map <C-n> :CocList -I symbols<CR>
        nn gd <Plug>(coc-definition)
        nn gr <Plug>(coc-references)
        nn gy <Plug>(coc-type-definition)
        nn gh :call CocAction('diagnosticInfo')<CR>
        nm <silent> [d <Plug>(coc-diagnostic-prev)
        nm <silent> ]d <Plug>(coc-diagnostic-next)
        nn K :call CocActionAsync('doHover')<CR>
        xn \f <Plug>(coc-format-selected)
        au FileType * if &ft!='qf'|nn <buffer> <CR> <Plug>(coc-codeaction-cursor)|end
        ino <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
        ino <expr><TAB> coc#pum#visible()?coc#pum#next(1):
          \ indent(".")<col(".")-1?coc#refresh():"\<TAB>"
        ino <expr><S-TAB> coc#pum#visible()?coc#pum#prev(1):"\<C-h>"
      ]]
    end
  },
  "christoomey/vim-tmux-navigator",
  "farmergreg/vim-lastplace",
  "pocco81/auto-save.nvim",
  "tpope/vim-repeat",
  "wellle/targets.vim",
  "machakann/vim-highlightedyank",
  "sheerun/vim-polyglot",
  {"numToStr/Comment.nvim", opts={}},
  {"nvim-treesitter/nvim-treesitter", opts = {}},
  {"echasnovski/mini.indentscope", opts={}},
  {"petertriho/nvim-scrollbar", opts={set_highlights=false}},
  {"windwp/nvim-autopairs", event = "InsertEnter", opts = { map_cr = false }},
  {"echasnovski/mini.splitjoin", opts = {mappings = {toggle = 'S'}}},
  {
    "echasnovski/mini.bracketed",
    opts = {
      undo = {suffix = ''},
      diagnostic = {suffix = ''}
    }
  },
  {
    "echasnovski/mini.animate",
    config = function()
      local animate = require('mini.animate')
      animate.setup({
        cursor = {timing = animate.gen_timing.cubic({duration = 100, unit = 'total'})},
        scroll = {enable = false},
        open = {enable = false},
        resize = {enable = false}
      })
    end
  },
  {
    "kevinhwang91/nvim-bqf",
    opts = {
      preview = {
        winblend = 0,
        win_height=999,
        show_scroll_bar=false
      }
    }
  },
  {
    "ggandor/leap.nvim",
    opts = {
      safe_labels = {}
    },
    init = function()
      vim.keymap.set(
        'n',
        '<Space>',
        function() require'leap'.leap{target_windows={vim.fn.win_getid()}} end,
        {buffer=bufnr, silent=true, nowait=true}
      )
    end
  },
  {
    "mizlan/iswap.nvim",
    event = "VeryLazy",
    init = function()
      vim.cmd[[
        nn L :ISwapNodeWithRight<CR>
        nn H :ISwapNodeWithLeft<CR>
      ]]
    end,
    opts = {
      flash_style = false,
      move_cursor = true,
    }
  },
  {
    "mattn/emmet-vim",
    init = function()
      vim.cmd[[
        vmap <C-e> <C-y>,
        imap <C-e> <C-y>,
      ]]
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {
      keymaps = {
        normal = "s",
        normal_cur = "ss",
        visual = "s",
      }
    }
  },
  {
    "qleveque/hexa.nvim",
    opts={
      keymaps = {
        ascii = {redo = 'U'},
        run = 'é'
      },
      run_cmd = function(file) return 'sil !tmux splitw "run -p \"'..file..'\""' end,
      ascii_left = true
    }
  },
  {
    "nvim-pack/nvim-spectre",
    lazy = "true",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      vim.cmd('map <C-r> :sil lua require"spectre".toggle()<CR>')
    end,
    opts = {
      is_insert_mode = true,
      live_update = true,
      mapping={
        ['run_current_replace'] = { map = "r" },
        ['run_replace'] = { map = "<S-r>" },
      },
      highlight = {
        search = "DiffText",
        replace = "DiffAdd"
      },
    }
  },
  {
    "SUSTech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      surrounds = {},
      keymaps = {
        init_selection = "_",
        node_incremental = "_",
        node_decremental = "-",
      },
    }
  },
  {
    "romgrk/barbar.nvim",
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    init = function()
      vim.cmd[[
        nn 6 <Cmd>BufferPrevious<CR>
        nn 9 <Cmd>BufferNext<CR>
        nn 7 <Cmd>BufferClose<CR>
        nn 8 <Cmd>BufferRestore<CR>
      ]]
      vim.g.barbar_auto_setup = false
    end,
    enabled = not vim.api.nvim_win_get_option(0, "diff"),
    opts = {
      exclude_ft={'qf','hexd'},
      sidebar_filetypes={
        NvimTree={ text=' '..vim.fn.fnamemodify(vim.fn.getcwd(), ":t")..'/' }
      },
      auto_hide=1,
    }
  },
  {
    "stevearc/aerial.nvim",
    lazy=true,
    cmd="AerialOpen",
    init = function()
      vim.cmd('map <C-g> :AerialOpen<CR>')
    end,
    opts={
      autojump = true,
      backends = {"treesitter"},
      close_on_select = true,
      keymaps = { ["<C-j>"] = false, ["<C-k>"] = false },
      layout = { width = 30 },
      resize_to_content = false,
      lazy_load = true,
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy=true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      vim.cmd [[
        map <C-t> :sil lua require'telescope.builtin'.find_files()<CR>
        map <C-p> :sil lua require'telescope.builtin'.oldfiles()<CR>
        map <C-s> :sil lua require'telescope.builtin'.live_grep()<CR>
      ]]
    end,
    config = function()
      local telescope_actions=require("telescope.actions")
      require('telescope').setup{defaults={
        mappings={i={
          ['<C-v>']={'<C-R>+',type='command'},
          ['<C-p>']=telescope_actions.cycle_history_prev,
          ['<C-n>']=telescope_actions.cycle_history_next,
          ['<Esc>']=telescope_actions.close,
          ['<S-Tab>']=telescope_actions.move_selection_previous,
          ['<Tab>']=telescope_actions.move_selection_next,
        }},
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
      }}
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy=true,
    cmd= "NvimTreeFindFile",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    init = function()
      vim.cmd[[
        au VimEnter,BufEnter,BufRead *NvimTree* setlocal statusline=_
        map <C-f> :NvimTreeFindFile<CR>
      ]]
    end,
    config = function()
      local ta=require('nvim-tree.api')
      local function path() return ta.tree.get_node_under_cursor().absolute_path end
      local function tree_attach(bufnr)
        local arr={
          ['A']=ta.fs.rename,
          ['cw']=ta.fs.rename_sub,
          ['yW']=ta.fs.copy.absolute_path,
          ['yw']=ta.fs.copy.relative_path,
          ['yy']=ta.fs.copy.node,
          ['dd']=ta.fs.remove,
          ['xx']=ta.fs.cut,
          ['T']=ta.fs.create,
          ['p']=ta.fs.paste,
          ['l']=ta.node.open.edit,
          ['h']=ta.node.navigate.parent_close,
          ['L']=ta.tree.change_root_to_node,
          ['H']=ta.tree.change_root_to_parent,
          ['é']=function() vim.cmd('sil !tmux splitw "run -p \\"'..path()..'\\""') end,
          ['<CR>']=function() vim.cmd('sil !o "'..path()..'"') end,
          ['<C-f>']=function() vim.cmd('wincmd p') end,
        }
        for k, v in pairs(arr) do
          vim.keymap.set('n',k,v,{buffer=bufnr,silent=true,nowait=true})
        end
      end
      require('nvim-tree').setup{
        update_focused_file = { enable = true },
        view={ signcolumn='no' },
        renderer={ group_empty=true, root_folder_label=false },
        on_attach=tree_attach,
        actions = {open_file = { window_picker = { enable = false } } },
      }
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require'catppuccin'.setup{
        flavour="auto",
        integrations = {
          nvimtree = false,
          barbar = true,
          coc_nvim = true,
          leap = true
        },
        custom_highlights = function(C)
          return {
            Active = { bg = C.base },
            Inactive = { bg = C.mantle },
            User1 = { bg = C.surface2 },
            WinSeparator = { bg = C.mantle, fg = C.surface2 },
            StatusLine = { bg = C.base, fg = C.surface2, underline = true },
            StatusLineNC = { bg = C.mantle, fg = C.surface2, underline = true },
            Cursor = { reverse = true },
            ScrollbarHandle = { bg = C.surface1 },
            ScrollbarCursorHandle = { bg = C.surface1 },
          }
        end
      }
      vim.cmd [[
        colorscheme catppuccin
        set stl=%1*\ \%f%m\ %0*%=
        au FocusLost * set winhl=Normal:Inactive
        au FocusGained,BufNew,BufLeave,BufRead * set winhl+=Normal:Active,NormalNC:Inactive
      ]]
    end
  },
})
