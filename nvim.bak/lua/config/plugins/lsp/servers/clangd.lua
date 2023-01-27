local M = {}

M.setup = function(lsp, config)
	require('clangd_extensions').setup {
		server = {
			capabilities = config.capabilities,
			on_attach = config.on_attach,
		},
	}
	-- lsp.clangd.setup {
	-- 	-- on_attach = function(client, bufnr)
	-- 	-- 	client.server_capabilities.documentFormattingProvider = false
	-- 	-- 	client.server_capabilities.documentRangeFormattingProvider = false
	-- 	-- 	config.on_attach(client, bufnr)
	-- 	-- end,
	-- }
end

return M
