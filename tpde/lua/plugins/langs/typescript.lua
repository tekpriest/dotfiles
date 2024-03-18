local utils = require 'core.utils'
return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'javascript', 'typescript', 'tsx' })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(
        opts.ensure_installed,
        { 'typescript-language-server', 'js-debug-adapter', 'prettierd' }
      )
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tsserver = {
          settings = {
            complete_function_calls = true,
            tsserver_format_options = { convertTabToSpaces = false },
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              },
            },
            -- enable checking javascript without a `jsconfig.json`
            -- DOCS https://www.typescriptlang.org/tsconfig
            implicitProjectConfiguration = { checkJs = true, target = 'ES2022' },
          },
        },
        -- ESLint
        -- eslint = {
        --   settings = {
        --     -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
        --     workingDirectory = { mode = 'auto' },
        --   },
        -- },
      },
      setup = {
        eslint = function()
          vim.api.nvim_create_autocmd('BufWritePre', {
            callback = function(event)
              local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = 'eslint' })[1]
              if client then
                local diag = vim.diagnostic.get(
                  event.buf,
                  { namespace = vim.lsp.diagnostic.get_namespace(client.id) }
                )
                if #diag > 0 then vim.cmd 'EslintFixAll' end
              end
            end,
          })
        end,
      },
    },
  },
  -- {
  --   'ray-x/lsp_signature.nvim',
  --   event = 'BufRead',
  --   ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue', 'go' },
  --   config = function() require('lsp_signature').on_attach() end,
  -- },
  -- {
  --   'pmizio/typescript-tools.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  --   opts = {
  --     on_attach = utils.on_attach,
  --     settings = {
  --       expose_as_code_action = 'all',
  --       -- code_lens = 'all',
  --     },
  --   },
  -- },
}
