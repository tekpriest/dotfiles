local tools = require 'rust-tools'

local M = {}

M.setup = function(lsp, config)
	tools.setup {
		server = {
			on_attach = function(client, bufnr)
				vim.keymap.set(
					'n',
					'<C-space>',
					tools.hover_actions.hover_actions,
					{ buffer = bufnr }
				)
				vim.keymap.set(
					'n',
					'gla',
					tools.code_action_group.code_action_group,
					{ buffer = bufnr }
				)
				config.on_attach(client, bufnr)
			end,
			capabilities = config.capabilities,
		},
	}
end

return M
