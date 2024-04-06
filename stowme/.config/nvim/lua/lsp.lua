local ensure_lsp_installed = {
  "html",
  "jsonls",
  "tsserver",
  "pyright",
  "clangd",
  "rust_analyzer",
  "eslint",
}
local ensure_null_ls_installed = {
  "flake8",
  "pylint",
  "prettier"
}

return {{
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
    {
      "aznhe21/actions-preview.nvim", 
      config = function()
        vim.keymap.set({ "v", "n" }, "<CR>", require("actions-preview").code_actions)
        vim.cmd('autocmd FileType qf nnoremap <buffer> <silent> <CR> <CR>')
        require("actions-preview").setup{
          telescope = {
            layout_config = { height = 0.5 }
          },
        }
      end,
    },
    {
      "ray-x/lsp_signature.nvim",
      event = "VeryLazy",
      opts = {hint_enable = false},
      config = function(_, opts) require'lsp_signature'.setup(opts) end
    }
  },
  config = function()
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
}}
