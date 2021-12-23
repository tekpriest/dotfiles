local lsp = require("lspconfig")
local cap = require("kr.lsp.utils.capabilities")

local elixir_lsp_loc = vim.fn.expand("~/.local/bin/elixir-ls/release/language_server.sh")
lsp.elixirls.setup({
	cmd = { elixir_lsp_loc },
	capabilities = cap,
	-- on_attach = on_attach,
	settings = {
		elixirLS = {
			dialyzerEnabled = false,
			fetchDeps = false,
		},
	},
})
