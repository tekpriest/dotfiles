local Utils = require 'tp.utils'
return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'neovim/nvim-lspconfig', dependencies = { 'folke/neodev.nvim' } },
    },
    config = function()
      local lspconfig = require 'lspconfig'
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- setting up neodev and neoconf first
      require('neodev').setup()
      require('neoconf').setup()

      vim.diagnostic.config {
        virtual_text = false,
        update_in_insert = true,
      }

      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'tsserver',
          'prismals',
          'taplo',
          'yamlls',
          'jsonls',
          'clangd',
          'bashls',
          'cmake',
          'dockerls',
          'docker_compose_language_service',
          'eslint',
          'gopls',
          'marksman',
          'zk',
          'sqlls',
          'terraformls',
          'zls',
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            lspconfig[server_name].setup {
              on_attach = Utils.on_attach,
              capabilities = capabilities,
            }
          end,
          ['tsserver'] = function()
            lspconfig.tsserver.setup {
              on_attach = Utils.on_attach,
              capabilities = capabilities,
            }
          end,
          ['lua_ls'] = function()
            lspconfig.lua_ls.setup {
              on_attach = Utils.on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  completion = { callSnippet = 'Replace' },
                  diagnostics = {
                    globals = { 'vim' },
                  },
                },
              },
            }
          end,
        },
      }
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
