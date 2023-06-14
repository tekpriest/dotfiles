return {
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
        'gofumpt',
        'stylua',
        'golines',
        'goimports-reviser',
        'tfsec',
        'shfmt',
        'shellcheck',
        'fish',
        'fish_indent',
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
      },
    }
    require('null-ls').setup {
      sources = {
        require 'typescript.extensions.null-ls.code-actions',
      },
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
}
