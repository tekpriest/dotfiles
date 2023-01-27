local M = {}

M.setup = function(lsp, config)
	require('flutter-tools').setup {
		ui = { border = 'shadow' },
		-- widget_guides = { enabled = true },
		lsp = {
			color = {
				enabled = true,
			},
			on_attach = config.on_attach,
			capabilities = config.capabilities,
		},
		settings = {
			showTodos = true,
			completeFunctionCalls = true,
			renameFilesWithClasses = 'always',
			enableSnippets = true,
		},
	}
end

return M
