return {
  -- add typescript to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'go', 'gomod', 'gosum' })
      end
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = { 'ray-x/go.nvim', 'ray-x/guihua.lua' },
    opts = {
      servers = {
        gopls = {
          settings = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      },
      setup = {
        gopls = function(_, opts)
          require('tp.core._util').on_attach(function(client, buffer)
            -- if client.name == 'tsserver' then
            -- end
          end)
          require('go').setup {
            max_line_len = 80,
            lsp_gofumpt = true,
            lsp_cfg = true,
            lsp_on_attach = require('tp.core._util').on_attach,
            trouble = true,
            luasnip = true,
          }
        end,
      },
    },
  },
}
