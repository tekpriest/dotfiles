-- if true then return {} end
return {
  -- {
  --   'VonHeikemen/lsp-zero.nvim',
  --   branch = 'v2.x',
  --   ft = {
  --     'lua',
  --     'go',
  --     'typescript',
  --     'javascript',
  --     'yaml',
  --     'json',
  --     'toml',
  --     'sh',
  --     'terraform',
  --     'fish',
  --     'bash',
  --   },
  --   dependencies = {
  --     { 'neovim/nvim-lspconfig' },
  --     {
  --       'williamboman/mason.nvim',
  --       build = function()
  --         pcall(vim.cmd, 'MasonUpdate')
  --       end,
  --     },
  --     { 'williamboman/mason-lspconfig.nvim' },
  --   },
  --   config = function()
  --     local lsp = require('lsp-zero').preset {
  --       configure_diagnostics = false,
  --     }
  --
  --     lsp.on_attach(function(client, bufnr)
  --       -- local opts = { buffer = bufnr, remap = false }
  --       -- vim.keymap.set('n', 'gd', function()
  --       --   vim.lsp.buf.definition()
  --       -- end, opts)
  --       -- vim.keymap.set('n', 'K', function()
  --       --   vim.lsp.buf.hover()
  --       -- end, opts)
  --       -- vim.keymap.set('n', '[d', function()
  --       --   vim.diagnostic.goto_prev()
  --       -- end, opts)
  --       -- vim.keymap.set('n', ']d', function()
  --       --   vim.diagnostic.goto_next()
  --       -- end, opts)
  --       -- vim.keymap.set('n', 'gr', function()
  --       --   vim.lsp.buf.references()
  --       -- end, opts)
  --       -- vim.keymap.set('n', '<leader>rn', function()
  --       --   vim.lsp.buf.rename()
  --       -- end, opts)
  --       -- vim.keymap.set('n', '<leader>ca', function()
  --       --   vim.lsp.buf.code_action()
  --       -- end, opts)
  --       -- vim.keymap.set('n', 'gs', function()
  --       --   vim.lsp.buf.signature_help()
  --       -- end, opts)
  --       -- vim.keymap.set('n', 'gl', function()
  --       --   vim.diagnostic.open_float()
  --       -- end, opts)
  --       -- vim.keymap.set('n', 'gi', function()
  --       --   vim.lsp.buf.implementation()
  --       -- end, opts)
  --
  --       vim.diagnostic.config {
  --         virtual_text = false,
  --       }
  --     end)
  --
  --     lsp.ensure_installed {
  --       'tsserver',
  --       'prismals',
  --       'jsonls',
  --       'gopls',
  --       'lua_ls',
  --       'yamlls',
  --       'taplo',
  --       'bashls',
  --     }
  --
  --     lsp.skip_server_setup { 'tsserver' }
  --
  --     lsp.setup()
  --
  --     require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
  --
  --     require('typescript').setup {}
  --   end,
  -- },
  { 'ellisonleao/glow.nvim', cmd = 'Glow', ft = { 'markdown' } },
  { 'b0o/SchemaStore.nvim', ft = { 'json', 'yaml' } },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = true },
        panel = { enabled = false },
      }
    end,
  },
  -- {
  --   'zbirenbaum/copilot-cmp',
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end,
  -- },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      local null_ls = require 'null-ls'
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

      require('mason').setup()
      require('mason-null-ls').setup {
        ensure_installed = {
          'prettierd',
          'prismaFmt',
          'gofumpt',
          'stylua',
          'golines',
          'goimports-reviser',
          'tfsec',
          'shfmt',
          'shellcheck',
        },
        automatic_installation = true,
        automatic_setup = true,
        handlers = {
          stylua = function()
            null_ls.register(null_ls.builtins.formatting.stylua)
          end,
          prettierd = function()
            null_ls.register(null_ls.builtins.formatting.prettierd)
          end,
          prismaFmt = function()
            null_ls.register(null_ls.builtins.formatting.prismaFmt)
          end,
        },
      }
      require('null-ls').setup {
        -- sources = { null_ls.builtins.formatting.prismaFmt },
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { bufnr = bufnr }
              end,
            })
          end
        end,
      }
    end,
  },
}
