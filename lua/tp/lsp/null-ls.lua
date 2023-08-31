local ok, null_ls = pcall(require, 'null-ls')
if not ok then
  return
end

local fmt = null_ls.builtins.formatting

require('mason-null-ls').setup {
  ensure_installed = {
    'gofumpt',
    'goimports-reviser',
    'golines',
    'gomodifytags',
    'hadolint',
    'prettierd',
    'shellcheck',
    'shfmt',
    'tflint',
    'tfsec',
    'rustywind',
  },
  automatic_installation = true,
  automatic_setup = true,
  handlers = {},
}
null_ls.setup {
  debounce = 150,
  debug = true,
  sources = {
    require 'typescript.extensions.null-ls.code-actions',
    fmt.prettierd.with { extra_filetypes = { 'svelte' } },
  },
}
