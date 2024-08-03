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

local notdiff = not vim.api.nvim_win_get_option(0, "diff")

require("lazy").setup({
  {
    'mrjones2014/smart-splits.nvim',
    opts = {},
    init = function()
      vim.cmd[[
        nn <C-h> :SmartCursorMoveLeft<CR>
        nn <C-j> :SmartCursorMoveDown<CR>
        nn <C-k> :SmartCursorMoveUp<CR>
        nn <C-l> :SmartCursorMoveRight<CR>
      ]]
    end
  },
  {
    "neoclide/coc.nvim",
    enabled = notdiff,
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
        nn \f :call CocActionAsync('format')<CR>
        nn \i :call CocActionAsync('runCommand', 'editor.action.organizeImport')<CR>
        xn \f <Plug>(coc-format-selected)
        nn \r <Plug>(coc-rename)
        au FileType * if &ft!='qf'|nn <buffer> <CR> <Plug>(coc-codeaction-cursor)|end
        ino <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
        ino <expr><TAB> coc#pum#visible()?coc#pum#next(1):
          \ indent(".")<col(".")-1?coc#refresh():"\<TAB>"
        ino <expr><S-TAB> coc#pum#visible()?coc#pum#prev(1):"\<C-h>"
      ]]
    end
  },
  {
    "farmergreg/vim-lastplace",
    enabled = notdiff
  },
  "pocco81/auto-save.nvim",
  "tpope/vim-repeat",
  "wellle/targets.vim",
  "machakann/vim-highlightedyank",
  {"numToStr/Comment.nvim", opts={}},
  {"sheerun/vim-polyglot", enabled = notdiff},
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = notdiff,
    opts = {}
  },
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
    "phelipetls/jsonpath.nvim",
    enabled = notdiff,
    init = function()
      vim.api.nvim_create_augroup("JsonSettings", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "json",
        group = "JsonSettings",
        callback = function()
          vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
          vim.keymap.set("n", "yp", function()
            vim.fn.setreg("+", require("jsonpath").get())
          end, { buffer = true })
        end,
      })
    end
  },
  {
    "kevinhwang91/nvim-bqf",
    enabled = notdiff,
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
    keys = {
      {
        '<Space>',
        function() require'leap'.leap{target_windows={vim.fn.win_getid()}} end,
        buffer=bufnr,
        silent=true,
        nowait=true
      }
    }
  },
  {
    "mizlan/iswap.nvim",
    enabled = notdiff,
    keys = {
      {'L', '<cmd>ISwapNodeWithRight<CR>'},
      {'H', '<cmd>ISwapNodeWithLeft<CR>'}
    },
    opts = {
      flash_style = false,
      move_cursor = true,
    }
  },
  {
    "mattn/emmet-vim",
    keys = {
      {'<C-e>', '<C-y>,', mode={'v', 'i'}, remap=true},
    }
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
    "nvim-pack/nvim-spectre",
    enabled = notdiff,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {"<C-r>", "<cmd>sil lua require'spectre'.toggle()<CR>"}
    },
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
    enabled = notdiff,
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
    enabled = notdiff,
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    init = function()
      vim.cmd[[
        nn <C-S-Tab> <Cmd>BufferPrevious<CR>
        nn <C-Tab> <Cmd>BufferNext<CR>
        nn Q <Cmd>BufferClose<CR>
        nn X <Cmd>BufferCloseAllButVisible<CR>
      ]]
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      exclude_ft={'qf'},
      sidebar_filetypes={
        NvimTree={ text=' '..vim.fn.fnamemodify(vim.fn.getcwd(), ":t")..'/' }
      },
      auto_hide=1,
    }
  },
  {
    "stevearc/aerial.nvim",
    enabled = notdiff,
    lazy=true,
    cmd="AerialOpen",
    keys = {
      {'<C-g>', '<cmd>AerialOpen<CR>'}
    },
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
    enabled = notdiff,
    lazy=true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {"<C-t>", "<cmd>sil lua require'telescope.builtin'.find_files()<CR>"},
      {"<C-p>", "<cmd>sil lua require'telescope.builtin'.oldfiles()<CR>"},
      {"<C-s>", "<cmd>sil lua require'telescope.builtin'.live_grep()<CR>"}
    },
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
    enabled = notdiff,
    cmd= "NvimTreeFindFile",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    keys = {
      {"<C-f>", "<cmd>NvimTreeFindFile<CR>"},
    },
    config = function()
      vim.cmd('au VimEnter,BufEnter,BufRead *NvimTree* setlocal statusline=_')
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
          ['é']=function() vim.cmd('sil !weznew -s "run -p \\"'..path()..'\\""') end,
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
        flavour=os.getenv("FLAVOR") or "auto",
        integrations = {
          nvimtree = false,
          barbar = true,
          coc_nvim = true,
          leap = true
        },
        custom_highlights = function(C)
          return {
            User1 = { bg = C.surface1 },
            WinSeparator = { bg = C.mantle, fg = C.surface2 },
            WinBar = { fg = C.overlay1 },
            StatusLine = { bg = C.base, fg = C.surface2, underline = true },
            StatusLineNC = { bg = C.mantle, fg = C.surface2, underline = true },
            Cursor = { reverse = true },
            ScrollbarHandle = { bg = C.surface1 },
            ScrollbarCursorHandle = { bg = C.surface1 },
          }
        end
      }
      vim.cmd('colorscheme catppuccin')
    end
  },
}, {
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "rplugin",
        "shada",
        "spellfile",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      }
    }
  }
})
