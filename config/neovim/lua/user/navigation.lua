local M = {}

function M.plugins(_diff)
  return {
    {
      url = "https://codeberg.org/andyg/leap.nvim",
      opts = { safe_labels = {} },
      keys = {
        {
          '<Space>',
          function() require'leap'.leap{ target_windows = { vim.fn.win_getid() } } end,
          buffer = bufnr,
          silent = true,
          nowait = true,
          mode = { 'v', 'n' },
        },
      },
    },
    {
      "kevinhwang91/nvim-bqf",
      opts = { preview = { winblend = 0, win_height = 999, show_scroll_bar = false } },
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
      end,
    },
    {
      "nvim-pack/nvim-spectre",
      dependencies = { "nvim-lua/plenary.nvim" },
      keys = { { "<C-r>", "<cmd>sil lua require'spectre'.toggle()<CR>" } },
      opts = {
        is_insert_mode = true,
        live_update = true,
        mapping = {
          ['run_current_replace'] = { map = "r" },
          ['run_replace'] = { map = "<S-r>" },
        },
        highlight = { search = "DiffText", replace = "DiffAdd" },
      },
    },
    {
      "stevearc/aerial.nvim",
      lazy = true,
      cmd = "AerialOpen",
      keys = { { '<C-z>', '<cmd>AerialOpen<CR>' } },
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      opts = {
        autojump = true,
        backends = { "treesitter" },
        close_on_select = true,
        keymaps = { ["<C-j>"] = false, ["<C-k>"] = false },
        layout = { width = 30 },
        resize_to_content = false,
        lazy_load = true,
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      lazy = true,
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys = {
        { "<C-t>", "<cmd>sil lua require'telescope.builtin'.find_files()<CR>" },
        { "<C-p>", "<cmd>sil lua require'telescope.builtin'.oldfiles()<CR>" },
        { "<C-s>", "<cmd>sil lua require'telescope.builtin'.live_grep()<CR>" },
      },
      config = function()
        local actions = require("telescope.actions")
        require('telescope').setup({ defaults = {
          mappings = { i = {
            ['<C-v>'] = { '<C-R>+', type = 'command' },
            ['<C-p>'] = actions.cycle_history_prev,
            ['<C-n>'] = actions.cycle_history_next,
            ['<Esc>'] = actions.close,
            ['<S-Tab>'] = actions.move_selection_previous,
            ['<Tab>'] = actions.move_selection_next,
          } },
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
            mirror = true,
          },
          layout_strategy = 'vertical',
        } })
      end,
    },
    {
      "nvim-tree/nvim-tree.lua",
      cmd = "NvimTreeFindFile",
      dependencies = { "kyazdani42/nvim-web-devicons" },
      keys = { { "<C-f>", "<cmd>NvimTreeFindFile<CR>" } },
      config = function()
        vim.cmd('au VimEnter,BufEnter,BufRead *NvimTree* setlocal statusline=_')
        local ta = require('nvim-tree.api')
        local function path() return ta.tree.get_node_under_cursor().absolute_path end
        local function tree_attach(bufnr)
          local arr = {
            ['A'] = ta.fs.rename,
            ['cw'] = ta.fs.rename_sub,
            ['yW'] = ta.fs.copy.absolute_path,
            ['yw'] = ta.fs.copy.relative_path,
            ['yy'] = ta.fs.copy.node,
            ['dd'] = ta.fs.remove,
            ['xx'] = ta.fs.cut,
            ['T'] = ta.fs.create,
            ['M'] = function()
              local node = ta.tree.get_node_under_cursor()
              local base_path = node.type == "directory" and path() or vim.fn.fnamemodify(path(), ":h")
              vim.ui.input({ prompt = "Create directory: " }, function(input)
                vim.fn.mkdir(base_path .. "/" .. input, "p")
                ta.tree.reload()
              end)
            end,
            ['p'] = ta.fs.paste,
            ['l'] = ta.node.open.edit,
            ['e'] = function() vim.cmd('sil !zj-wrap split "e \\"' .. path() .. '\\""') end,
            ['h'] = ta.node.navigate.parent_close,
            ['é'] = function() vim.cmd('sil !zj-wrap split "run -p \\"' .. path() .. '\\""') end,
            ['É'] = function() vim.cmd('sil !zj-wrap split run') end,
            ['!'] = function() vim.cmd('sil !' .. vim.fn.input('!') .. ' ' .. vim.fn.fnameescape(path())) end,
            ['<CR>'] = function() vim.cmd('sil !o "' .. path() .. '"') end,
            ['<C-f>'] = function() vim.cmd('wincmd p') end,
            ['<C-g>'] = function() vim.cmd('sil !git-wrap ' .. vim.fn.nr2char(vim.fn.getchar()) .. ' -f"' .. path() .. '"') end,
          }
          for k, v in pairs(arr) do
            vim.keymap.set('n', k, v, { buffer = bufnr, silent = true, nowait = true })
          end
        end
        require('nvim-tree').setup({
          sync_root_with_cwd = true,
          update_focused_file = { enable = true },
          view = { signcolumn = 'no' },
          renderer = { group_empty = true, root_folder_label = false },
          on_attach = tree_attach,
          actions = { open_file = { window_picker = { enable = false } } },
        })
      end,
    },
  }
end

return M
