return {
  'jay-babu/mason-null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'neovim/nvim-lspconfig',
  },
  init = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        -- When I use gq, I don't want LSP to perform formatting for me for most kinds of buffers.
        -- See: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1130#issuecomment-1268760653
        vim.bo[args.buf].formatexpr = nil
      end,
    })
  end,
  config = function()
    local null_ls = require 'null-ls'
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    require('mason').setup()
    require('mason-null-ls').setup {
      ensure_installed = {
        'black',
        'buf',
        'clang-format',
        'gofumpt',
        'goimports-reviser',
        'golines',
        'prettierd',
        'shellcheck',
        'shfmt',
        'stylua',
        'tfsec',
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
      debounce = 150,
      sources = {
        require 'typescript.extensions.null-ls.code-actions',
      },
      on_attach = function(client, bufnr)
        require('tp.lsp.setup').on_attach(client,bufnr)
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
