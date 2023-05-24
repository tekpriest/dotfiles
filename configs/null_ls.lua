local null_ls = require 'null-ls'
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local opts = {
  sources = {
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd.with {
      condiction = function(util)
        return util.root_has_file 'package.json'
            or util.root_has_file '.prettierrc'
            or util.root_has_file '.prettierrc.json'
            or util.root_has_file '.prettierrc.js'
      end,
    },
    null_ls.builtins.diagnostics.eslint_d.with {
      condition = function(util)
        return util.root_has_file '.eslintrc.json'
            or util.root_has_file '.eslintrc.js'
      end,
    },
    -- null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.formatting.taplo,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.diagnostics.hadolint,
    -- null_ls.builtins.diagnostics.prismaFmt,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.cmake_format,
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

return opts
