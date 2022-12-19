local M = {}

M.setup = function(lsp, config)
	lsp.tsserver.setup {
		capabilities = config.capabilities,
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			config.on_attach(client, bufnr)
		end,
	}
end

return M
