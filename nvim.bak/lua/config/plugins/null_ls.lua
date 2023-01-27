-- formatting
local null = require 'null-ls'
local b = null.builtins
local M = {}

M.setup_null = function(config)
	null.setup {
		sources = {
			b.formatting.stylua,
			b.formatting.prettierd,
			b.formatting.prismaFmt,
			b.formatting.gofumpt,
			b.formatting.golines,
			b.formatting.gdformat,
			b.formatting.zigfmt,
			b.diagnostics.eslint_d.with {
				diagnostics_format = '#{m} [#{c}]',
				condition = function(utils)
					return utils.root_has_file { '.eslintrc', '.eslintrc.json' }
				end,
			},
			b.diagnostics.solhint,
			b.diagnostics.golangci_lint,
		},
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	}
end

return M
