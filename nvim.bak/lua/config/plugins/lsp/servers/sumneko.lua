local M = {}

M.setup = function(lsp, config)
	lsp.sumneko_lua.setup {
		capabilities = config.capabilities,
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			config.on_attach(client, bufnr)
		end,
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
					path = vim.split(package.path, ';'),
				},
				diagnostics = {
					globals = { 'vim', 'it', 'describe' },
				},
			},
		},
	}
end

return M
