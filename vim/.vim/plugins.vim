call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'dstein64/nvim-scrollview'
Plug 'farmergreg/vim-lastplace'
Plug 'github/copilot.vim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neovim/nvim-lspconfig'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
Plug 'romgrk/barbar.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/argtextobj.vim'
Plug 'voldikss/vim-floaterm'
Plug 'williamboman/nvim-lsp-installer'
call plug#end()

let g:copilot_no_tab_map=v:true
let g:floaterm_opener='edit'
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1
let g:user_emmet_leader_key='<C-Z>'
let g:floaterm_height=0.8
let g:floaterm_width=0.8

lua << EOF
  local language_servers = {
    'pyright',
    'clangd',
    'tsserver',
    'jsonls',
    'html',
  }

  require'colorizer'.setup{}
  require'bufferline'.setup{
    auto_hide=true,
    exclude_ft={'qf'},
  }
  require'nvim-treesitter.configs'.setup{
    highlight={
      enable=true,
    }
  }
  require'telescope'.setup{
    defaults={
      mappings={
        i={
          ['<ESC>']=require('telescope.actions').close,
          ['<C-V>']={'<C-R>+',type="command"},
        }
      }
    }
  }
  require'nvim-lsp-installer'.setup{
    ensure_installed = language_servers,
    automatic_installation = true,
  }

  -- Autocompletion
  local cmp = require'cmp'
  cmp.setup {
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, {'i','s'}),
    }),
    sources = {
      { name = 'nvim_lsp' },
    },
  }

  -- Language servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  local on_attach = function(client, bufnr)
    local opts = {noremap=true, silent=true, buffer=bufnr}
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
  end
  for _,language_server in pairs(language_servers) do
    require'lspconfig'[language_server].setup{
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end
EOF
