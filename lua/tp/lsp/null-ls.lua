local ok, null_ls = pcall(require 'null-ls')
if not ok then
  return
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local fmt = null_ls.builtins.formatting
local dgn = null_ls.builtins.diagnostics

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
    'ktlint',
    'codelldb',
  },
  automatic_installation = true,
  automatic_setup = true,
  -- handlers = {
  --   stylua = function()
  --     null_ls.register(null_ls.builtins.formatting.stylua)
  --   end,
  --   prettierd = function()
  --     null_ls.register(null_ls.builtins.formatting.prettierd)
  --   end,
  -- },
}
null_ls.setup {
  debounce = 150,
  debug = true,
  sources = {
    require 'typescript.extensions.null-ls.code-actions',
  },
  -- on_attach = require('tp.lsp.setup').on_attach,
  -- on_attach = function(client, bufnr)
  --   if client.supports_method 'textDocument/formatting' then
  --     vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
  --     vim.api.nvim_create_autocmd('BufWritePre', {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         vim.lsp.buf.format { bufnr = bufnr }
  --       end,
  --     })
  --   end
  -- end,
}
