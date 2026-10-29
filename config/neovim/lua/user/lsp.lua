local M = {}

local BORDER = "rounded"

local function configure_diagnostics()
  vim.diagnostic.config({
    float = { border = BORDER },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.HINT] = '',
        [vim.diagnostic.severity.INFO] = '',
      },
    },
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = BORDER })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = BORDER })
end

local function organize_imports()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.organizeImports", "source.organizeImports.ts" },
      diagnostics = {},
    },
  })
end

local function apply_fixes()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "quickfix", "source.fixAll", "source.organizeImports", "source.organizeImports.ts" },
      diagnostics = {},
    },
  })
end

local function format_selection()
  local start_pos = vim.api.nvim_buf_get_mark(0, "<")
  local end_pos = vim.api.nvim_buf_get_mark(0, ">")
  vim.lsp.buf.format({
    async = true,
    range = {
      ["start"] = { start_pos[1], start_pos[2] },
      ["end"] = { end_pos[1], end_pos[2] },
    },
  })
end

local function setup_keymaps()
  vim.keymap.set("n", "<C-n>", vim.lsp.buf.document_symbol)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition)
  vim.keymap.set("n", "gr", vim.lsp.buf.references)
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)
  vim.keymap.set("n", "gh", function() vim.diagnostic.open_float(nil, { border = BORDER, focus = false }) end)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
  vim.keymap.set("n", "K", vim.lsp.buf.hover)
  vim.keymap.set("n", "\\f", function() vim.lsp.buf.format({ async = true }) end)
  vim.keymap.set("x", "\\f", format_selection)
  vim.keymap.set("n", "\\i", organize_imports)
  vim.keymap.set("n", "\\q", apply_fixes)
  vim.keymap.set("n", "\\a", vim.lsp.buf.code_action)
  vim.keymap.set("n", "\\r", vim.lsp.buf.rename)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
      if vim.bo[args.buf].filetype ~= "qf" then
        vim.keymap.set("n", "<CR>", vim.lsp.buf.code_action, { buffer = args.buf })
      end
    end,
  })
end

local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok_blink, blink = pcall(require, "blink.cmp")
  if ok_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end
  return capabilities
end

local function setup_server(server, capabilities, opts)
  opts = opts or {}
  opts.capabilities = vim.tbl_deep_extend("force", capabilities, opts.capabilities or {})

  -- Neovim 0.11+ API
  if vim.lsp and vim.lsp.config and vim.lsp.enable then
    local ok_config = pcall(vim.lsp.config, server, opts)
    if not ok_config then
      return false
    end
    return pcall(vim.lsp.enable, server)
  end

  -- Backward compatibility (Neovim < 0.11)
  local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
  if not ok_lspconfig then
    return false
  end

  local ok_server, cfg = pcall(function()
    return lspconfig[server]
  end)
  if ok_server and cfg then
    cfg.setup(opts)
    return true
  end

  return false
end

local function setup_any(servers, capabilities, opts)
  for _, server in ipairs(servers) do
    if setup_server(server, capabilities, opts) then
      return server
    end
  end
  return nil
end

local function tsdk_path(bin_name)
  local bin = vim.fn.exepath(bin_name)
  if bin == nil or bin == "" then
    return nil
  end
  local base = vim.fn.fnamemodify(bin, ":h:h")
  return base .. "/lib/node_modules/typescript/lib"
end

local function setup_vue(capabilities)
  local vue_language_server_bin = vim.fn.exepath("vue-language-server")
  local vue_language_server_path = nil
  if vue_language_server_bin ~= nil and vue_language_server_bin ~= "" then
    vue_language_server_path = vim.fn.fnamemodify(vue_language_server_bin, ":h:h") .. "/lib/node_modules/@vue/language-server"
  end

  local vue_plugin = {
    name = "@vue/typescript-plugin",
    location = vue_language_server_path,
    languages = { "vue" },
    configNamespace = "typescript",
  }

  local has_vtsls = setup_server("vtsls", capabilities, {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = { vue_plugin },
        },
      },
    },
    -- Keep vtsls for TS/JS only; vue_ls handles .vue in non-hybrid mode below.
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
  })

  if not has_vtsls then
    setup_any({ "ts_ls", "tsserver" }, capabilities)
  end

  setup_any({ "vue_ls", "volar" }, capabilities, {
    filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    init_options = {
      vue = {
        hybridMode = false,
      },
      typescript = {
        tsdk = tsdk_path("tsserver"),
      },
    },
  })
end

local function setup_servers(capabilities)
  setup_server("nil_ls", capabilities)
  setup_any({ "ruff", "ruff_lsp" }, capabilities)
  setup_server("pyright", capabilities)
  setup_server("rust_analyzer", capabilities)
  setup_server("lua_ls", capabilities, {
    settings = {
      Lua = {
        hint = { enable = false },
      },
    },
  })

  setup_vue(capabilities)

  setup_server("html", capabilities)
  setup_server("cssls", capabilities)
  setup_server("jsonls", capabilities)
  setup_server("clangd", capabilities)
  setup_server("eslint", capabilities)
end

local function setup_lsp()
  configure_diagnostics()
  setup_keymaps()
  local capabilities = make_capabilities()
  setup_servers(capabilities)
end

function M.plugins(diff)
  return {
    {
      "saghen/blink.cmp",
      enabled = not diff,
      version = "*",
      dependencies = { "rafamadriz/friendly-snippets" },
      opts = {
        enabled = function()
          return vim.bo.filetype ~= "DressingInput"
        end,
        keymap = {
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
          ["<CR>"] = { "accept", "fallback" },
        },
        appearance = {
          nerd_font_variant = "normal",
        },
        completion = {
          menu = { border = "rounded" },
          documentation = { auto_show = true, window = { border = "rounded" } },
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        signature = { enabled = true },
      },
    },
    {
      "stevearc/dressing.nvim",
      enabled = not diff,
      opts = {
        select = {
          enabled = true,
          backend = { "builtin" },
          builtin = {
            border = "rounded",
            relative = "editor",
            max_width = 80,
            min_width = 40,
          },
        },
        input = {
          enabled = true,
          border = "rounded",
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      enabled = not diff,
      init = setup_lsp,
    },
  }
end

return M
