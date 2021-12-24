local null = require("null-ls")
local formatting = null.builtins.formatting
--
-- local sources = {
-- 	-- Diagnostics
-- 	diagnostics.write_good,
-- 	diagnostics.credo,
-- 	diagnostics.eslint_d,
-- 	diagnostics.hadolint,
-- 	diagnostics.yamllint,
-- 	diagnostics.revive,
-- 	diagnostics.tsc,
-- 	diagnostics.eslint_d,
--
local sources = {
  formatting.dart_format,
  formatting.erlfmt,
  formatting.gofmt,
  formatting.goimports,
  formatting.golines,
  formatting.mix,
  formatting.prismaFmt,
  formatting.eslint_d,
  null.builtins.formatting.prettier.with({
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
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})
