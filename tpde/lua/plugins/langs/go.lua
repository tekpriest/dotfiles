return {
  {
    'nvim-treesitter/nvim-treesitter',
    init = function()
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.gotmpl = {
        install_info = {
          url = 'https://github.com/ngalaiko/tree-sitter-go-template',
          files = { 'src/parser.c' },
        },
        filetype = 'gotmpl',
        used_by = { 'gohtmltmpl', 'gotexttmpl', 'gotmpl', 'yaml' },
      }
    end,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'go', 'gomod', 'gowork', 'gosum' })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'delve',
        'gotests',
        'golangci-lint',
        'gofumpt',
        'goimports',
        'golangci-lint-langserver',
        'impl',
        'gomodifytags',
        'iferr',
        'gotestsum',
      })
    end,
  },
  -- {
  --   'ray-x/go.nvim',
  --   dependencies = {
  --     'ray-x/guihua.lua',
  --     'neovim/nvim-lspconfig',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   opts = {},
  --   config = function(_, opts)
  --     require('go').setup(opts)
  --   end,
  --   ft = { 'go', 'gomod', 'gowork' },
  --   build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  -- },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              experimentalPostfixCompletions = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
            },
          },
          init_options = { usePlaceholders = true },
        },
        -- golangci_lint_ls = {},
      },
      setup = {
        gopls = function(_, _)
          local lsp_utils = require 'core.utils'
          lsp_utils.on_attach(function(client, bufnr)
            local map = function(mode, lhs, rhs, desc)
              if desc then
                desc = desc
              end
              vim.keymap.set(
                mode,
                lhs,
                rhs,
                { silent = true, desc = desc, buffer = bufnr, noremap = true }
              )
            end
            -- stylua: ignore
            if client.name == "gopls" then
              map("n", "<leader>ly", "<cmd>GoModTidy<cr>", "Go Mod Tidy")
              map("n", "<leader>lc", "<cmd>GoCoverage<cr>", "Go Test Coverage")
              map("n", "<leader>lt", "<cmd>GoTest<cr>", "Go Test")
              map("n", "<leader>lR", "<cmd>GoRun<cr>", "Go Run")
              map("n", "<leader>dT", "<cmd>lua require('dap-go').debug_test()<cr>", "Go Debug Test")
              if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end
          end)
        end,
      },
    },
  },
}
