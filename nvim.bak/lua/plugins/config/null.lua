local ok, null = pcall(require, "null-ls")
if not ok then
	return
end

local formatting = null.builtins.formatting
local diagnostics = null.builtins.diagnostics

null.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
		formatting.stylua,
		-- diagnostics.eslint_d,
		null.builtins.code_actions.eslint_d,
	},
})
