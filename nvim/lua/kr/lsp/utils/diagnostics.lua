local colors = require("kr.utils.colors")
local set_highlight = require("kr.utils.set-highlight")

vim.diagnostic.config({
	signs = false, -- Disable LSP signs
	underline = true, -- Underline diagnostics
	virtual_text = false, -- Hide virtual text
})

set_highlight({
	list = {
		-- In code colors
		{ group = "DiagnosticslineError", foreground = colors.red },
		{ group = "DiagnosticUnderlineWarning", foreground = colors.yellow },
		{ group = "DiagnosticUnderlineInformation", foreground = colors.blue },
		{ group = "DiagnosticUnderlineHint", foreground = colors.orange },

		-- Floating window colors
		{ group = "DiagnosticFloatingError", foreground = colors.red },
		{ group = "DiagnosticFloatingWarn", foreground = colors.yellow },
		{ group = "DiagnosticFloatingInfo", foreground = colors.blue },
		{ group = "DiagnosticFloatingHint", foreground = colors.orange },

		-- General purpose colors
		{ group = "DiagnosticError", foreground = colors.red },
		{ group = "DiagnosticWarn", foreground = colors.yellow },
		{ group = "DiagnosticInfo", foreground = colors.blue },
		{ group = "DiagnosticHint", foreground = colors.orange },
	},
})

vim.cmd([[
 sign define DiagnosticSignError text= texthl=DiagnosticSignError
    sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn
    sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo
    sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint
]])
