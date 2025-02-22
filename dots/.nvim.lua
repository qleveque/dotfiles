-- Download lazy
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

-- Vimrc
vim.cmd('source ~/.vimrc')

-- No syntax for performance
vim.cmd('syntax off')

-- Tabs
vim.cmd('set tabstop=2 shiftwidth=2')

-- Use cb for the clipboard
vim.g.clipboard = {
  copy = { ['+'] = 'cb copy' },
  paste = { ['+'] = 'cb paste' },
  cache_enabled = 0
}

-- Specific configs
local light = os.getenv("NVIM_LIGHT");
if os.getenv("NVIM_GITDIFF") then
  vim.cmd[[
    nn gf :exe 'sil !wez new "nvim "$FILE" +'.line('.').'"'<CR>
    au BufRead /tmp/* setl noma
  ]]
  light = true
elseif os.getenv("NVIM_GITMERGE") then
  vim.cmd[[
    nn dp 1dp3dp:wa<CR>
    nm doh 1dodp
    nm dol 3dodp
    au VimEnter * :winc h
  ]]
  light = true
elseif os.getenv("NVIM_GIT") then
  vim.cmd('syntax on')
  light = true
end

-- Light plugins
nvim_plugins = {
  "pocco81/auto-save.nvim",
  "tpope/vim-repeat",
  {"numToStr/Comment.nvim", opts={}},
  {"petertriho/nvim-scrollbar", opts={set_highlights=false}},
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
    "ggandor/leap.nvim",
    opts = { safe_labels = {} },
    keys = {
      {
        '_',
        function() require'leap'.leap{target_windows={vim.fn.win_getid()}} end,
        buffer=bufnr, silent=true, nowait=true, mode={'v', 'n'}
      }
    }
  },
  {
    "kylechui/nvim-surround",
    opts = { keymaps = { normal = "s", normal_cur = "ss", visual = "s", } },
    version = "*",
    event = "VeryLazy",
  },
  "machakann/vim-highlightedyank",
  {"echasnovski/mini.indentscope", opts={}},
  {
    "echasnovski/mini.animate",
    config = function()
      require('mini.animate').setup({
        cursor = {timing = require('mini.animate').gen_timing.cubic({duration = 150, unit = 'total'})},
        scroll = {enable = false}, open = {enable = false}, resize = {enable = false}
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require'nvim-treesitter.configs'.setup({
        highlight = { enable = true },
        additional_vim_regex_highlighting = false
      })
      vim.treesitter.language.register('bash', 'zsh')
    end
  }
}

if not light then
  -- Heavier plugins
  local heavier_plugins = {
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "VonHeikemen/lsp-zero.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "L3MON4D3/LuaSnip",
        "nvimtools/none-ls.nvim",
        "jay-babu/mason-null-ls.nvim",
        -- Real dependencies
        "nvim-lua/plenary.nvim",
        {
          "ray-x/lsp_signature.nvim",
          event = "VeryLazy",
          opts = {hint_enable = false},
          config = function(_, opts) require'lsp_signature'.setup(opts) end
        }
      },
      config = function()
        local ensure_lsp_installed = { "html", "jsonls", "tsserver", "pyright", "clangd", "rust_analyzer", "eslint", }
        local ensure_null_ls_installed = { "flake8", "pylint", "prettier" }
        -- utils
        local lsp_zero = require'lsp-zero'
        local cmp = require'cmp'
        local luasnip = require'luasnip'
        local null_ls = require'null-ls'
        function FormatFunction()
          local gm=vim.api.nvim_buf_get_mark
          vim.lsp.buf.format({
            async = true,
            range = { ["start"] = gm(0, "<"), ["end"] = gm(0, ">") }
          })
        end
        function HasWordsBefore()
          local line, c = unpack(vim.api.nvim_win_get_cursor(0))
          local b = vim.api.nvim_buf_get_lines(0,line-1,line,true)[1]
          return c ~= 0 and b:sub(c,c):match("%s")==nil
        end
        function Tab(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif HasWordsBefore() then
            cmp.complete()
          else
            fallback()
          end
        end
        function STab(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end

        -- mason - null_ls
        require'mason'.setup({})
        require'mason-lspconfig'.setup({
          ensure_installed = ensure_lsp_installed,
          handlers = { lsp_zero.default_setup },
        })
        require("mason-null-ls").setup({
          ensure_installed = ensure_null_ls_installed,
          automatic_installation = true,
          handlers = {},
        })

        -- cmp
        local cmp_win = cmp.config.window.bordered
        cmp.setup({
          snippet = {
            expand = function(args) luasnip.lsp_expand(args.body) end,
          },
          window = { completion = cmp_win(), documentation = cmp_win() },
          mapping = {
            ["<Tab>"] = cmp.mapping(Tab, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(STab, { "i", "s" }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
          },
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer' },
          })
        })

        -- lsp-config
        vim.diagnostic.config({ virtual_text = false })
        lsp_zero.on_attach(function (_, bufnr) lsp_zero.default_keymaps({buffer = bufnr}) end)
        vim.api.nvim_set_keymap("n", 'gh', "<cmd>lua vim.diagnostic.open_float()<CR>", {})
        vim.api.nvim_set_keymap("v", "\\f", "<Esc><cmd>lua FormatFunction()<CR>", {})
      end
    },
    "farmergreg/vim-lastplace",
    "wellle/targets.vim",
    {"windwp/nvim-autopairs", event = "InsertEnter", opts = { map_cr = false }},
    {"echasnovski/mini.splitjoin", opts = {mappings = {toggle = 'S'}}},
    {
      "kevinhwang91/nvim-bqf",
      opts = { preview = { winblend = 0, win_height=999, show_scroll_bar=false } }
    },
    {
      "mattn/emmet-vim",
      keys = { {'<C-e>', '<C-y>,', mode={'v', 'i'}, remap=true}, }
    },
    {
      "phelipetls/jsonpath.nvim",
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
      "nvim-pack/nvim-spectre",
      dependencies = { "nvim-lua/plenary.nvim" },
      keys = { {"<C-r>", "<cmd>sil lua require'spectre'.toggle()<CR>"} },
      opts = {
        is_insert_mode = true,
        live_update = true,
        mapping={ ['run_current_replace'] = { map = "r" }, ['run_replace'] = { map = "<S-r>" }, },
        highlight = { search = "DiffText", replace = "DiffAdd" },
      }
    },
    {
      "SUSTech-data/wildfire.nvim",
      event = "VeryLazy",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      opts = { surrounds = {},
        keymaps = {
          init_selection = '<Space>',
          node_incremental = '<Space>',
          node_decremental = '<S-Space>',
        },
      }
    },
    {
      "romgrk/barbar.nvim",
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
        sidebar_filetypes={ NvimTree={ text=' '..vim.fn.fnamemodify(vim.fn.getcwd(), ":t")..'/' } },
        auto_hide=1,
      }
    },
    {
      "stevearc/aerial.nvim",
      lazy=true,
      cmd="AerialOpen",
      keys = { {'<C-z>', '<cmd>AerialOpen<CR>'} },
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
      keys = {
        {"<C-t>", "<cmd>sil lua require'telescope.builtin'.find_files()<CR>"},
        {"<C-p>", "<cmd>sil lua require'telescope.builtin'.oldfiles()<CR>"},
        {"<C-s>", "<cmd>sil lua require'telescope.builtin'.live_grep()<CR>"}
      },
      config = function()
        local actions=require("telescope.actions")
        require('telescope').setup{defaults={
          mappings={i={
            ['<C-v>']={'<C-R>+',type='command'},
            ['<C-p>']=actions.cycle_history_prev,
            ['<C-n>']=actions.cycle_history_next,
            ['<Esc>']=actions.close,
            ['<S-Tab>']=actions.move_selection_previous,
            ['<Tab>']=actions.move_selection_next
          }},
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
            mirror = true,
          },
          layout_strategy = 'vertical',
        }}
      end
    },
    {
      "nvim-tree/nvim-tree.lua",
      cmd= "NvimTreeFindFile",
      dependencies = { "kyazdani42/nvim-web-devicons" },
      keys = { {"<C-f>", "<cmd>NvimTreeFindFile<CR>"}, },
      config = function()
        vim.cmd('au VimEnter,BufEnter,BufRead *NvimTree* setlocal statusline=_')
        local ta=require('nvim-tree.api')
        local function path() return ta.tree.get_node_under_cursor().absolute_path end
        local function filename() return ta.tree.get_node_under_cursor().name end
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
            ['e']=function() vim.cmd('sil !wez split "e \\"'..path()..'\\""') end,
            ['h']=ta.node.navigate.parent_close,
            ['é']=function() vim.cmd('sil !wez split "run -p \\"'..path()..'\\""') end,
            ['É']=function() vim.cmd('sil !wez split run') end,
            ['<CR>']=function() vim.cmd('sil !o "'..path()..'"') end,
            ['<C-f>']=function() vim.cmd('wincmd p') end,
            ['<C-g>']=function()
              vim.cmd('sil !wez new "gitw '..vim.fn.nr2char(vim.fn.getchar())..' \\"'..path()..'\\""')
            end,
            ['Y']=function() vim.cmd('sil !cd $(dirname "'..path()..'") && filecb copy "'..filename()..'"') end,
            ['P']=function() vim.cmd('sil !cd $(dirname "'..path()..'") && filecb paste') end,
          }
          for k, v in pairs(arr) do
            vim.keymap.set('n',k,v,{buffer=bufnr,silent=true,nowait=true})
          end
        end
        require('nvim-tree').setup{
          sync_root_with_cwd = true,
          update_focused_file = { enable = true },
          view={ signcolumn='no' },
          renderer={ group_empty=true, root_folder_label=false },
          on_attach=tree_attach,
          actions = {open_file = { window_picker = { enable = false } } },
        }
      end
    }
  }
  table.move(heavier_plugins, 1, #heavier_plugins, #nvim_plugins + 1, nvim_plugins)
end

-- Theme
local theme = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require'catppuccin'.setup{
      flavour='Mocha',
      transparent_background = true,
      integrations = { nvimtree = false, barbar = true, leap = true },
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
}
table.insert(nvim_plugins, theme)

-- Load lazy
disabled={'gzip','netrwPlugin','rplugin','shada','spellfile','tarPlugin','tohtml','tutor','zipPlugin'}
require("lazy").setup(nvim_plugins, { performance = { rtp = { disabled = disabled}}})
