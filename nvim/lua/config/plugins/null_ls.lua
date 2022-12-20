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
			-- b.formatting.prettier,
			---diagnostics
			-- b.code_actions.eslint_d,
			-- b.diagnostics.eslint_d.with({
			-- 	diagnostics_format = "#{m} [#{c}]",
			-- 	condition = function(utils)
			-- 		print(utils.root_has_file({ ".eslintrc.js" }))
			-- 		return utils.root_has_file({ ".eslintrc", ".eslintrc.json" })
			-- 	end,
			-- }),
		},
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	}
end

return M
