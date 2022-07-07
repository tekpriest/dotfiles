local options = {
	signs = {
		Error = "",
		Warn = "",
		Hint = "",
		Info = "",
	},
	diagnostic = {
		virtual_text = false,
		signs = { active = true },
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	},
}

return options
