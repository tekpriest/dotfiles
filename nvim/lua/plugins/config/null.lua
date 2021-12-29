local null = require("null-ls")
local formatting = null.builtins.formatting
local diagnostics = null.builtins.diagnostics
local on_attach = require("plugins.config.lsp")
--
-- local sources = {
-- 	-- Diagnostics
-- 	diagnostics.write_good,
-- 	diagnostics.credo,
-- 	diagnostics.hadolint,
-- 	diagnostics.yamllint,
-- 	diagnostics.revive,
-- 	diagnostics.tsc,
-- 	diagnostics.eslint_d,
--
local sources = {
  diagnostics.eslint_d,
  null.builtins.code_actions.eslint_d,
  formatting.dart_format,
  formatting.erlfmt,
  formatting.gofmt,
  formatting.goimports,
  formatting.golines,
  formatting.mix,
  formatting.prismaFmt,
  formatting.eslint_d,
  formatting.prettier.with({
    filetypes = {
      "javascript",
      "typescript",
      "css",
      "scss",
      "html",
      "json",
      "yaml",
      "markdown",
      "graphql",
      "md",
      "text",
    },
  }),
  null.builtins.formatting.stylua.with({
    args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
  }),
}

null.setup({
  sources = sources,
  debug = false,
  on_attach = on_attach,
})
