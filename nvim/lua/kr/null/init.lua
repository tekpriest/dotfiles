local null = require("null-ls")
local null_h = require("null-ls.helpers")
local formatting = null.builtins.formatting
local diagnostics = null.builtins.diagnostics
local actions = null.builtins.code_actions
local completion = null.builtins.completion
--
local sources = {
	-- Formatters
	formatting.prettier,
	formatting.stylua,
	formatting.eslint_d,
	formatting.deno_fmt,
	formatting.dart_format,
	formatting.erlfmt,
	formatting.fixjson,
	formatting.gofmt,
	formatting.goimports,
	formatting.golines,
	formatting.taplo,
	formatting.mix,
	formatting.prismafmt,
	formatting.trim_whitespace,
	formatting.shfmt.with({ args = { "-i=4" } }),

	-- Diagnostics
	diagnostics.write_good,
	diagnostics.credo,
	diagnostics.eslint_d,
	diagnostics.hadolint,
	diagnostics.yamllint,
	diagnostics.revive,
	diagnostics.tsc,
	diagnostics.eslint_d,
	--null.builtins.diagnostics.luacheck,

	-- Actions
	actions.gitsigns,
	actions.refactoring,
	actions.eslint_d,

	-- Completions
	completion.spell,
	completion.luasnip,

	-- If eslint exists, don't use prettier for js/ts files
	null_h.conditional(function(utils)
		local has_eslint = utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.json")

		if has_eslint then
			return formatting.prettier.with({
				filetypes = {
					"vue",
					"css",
					"html",
					"yaml",
					"markdown",
					"json",
				},
				args = {
					"--stdin-filepath",
					"$FILENAME",
				},
			})
		else
			return formatting.prettier.with({
				filetypes = {
					"vue",
					"css",
					"html",
					"yaml",
					"markdown",
					"json",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				args = {
					"--stdin-filepath",
					"$FILENAME",
				},
			})
		end
	end),
}

require("null-ls").setup({
  sources = sources,
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})

