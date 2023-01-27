require('tokyonight').setup {
	style = 'night',
	styles = {
		comments = {
			fg = '#596c3d',
			bold = true,
		},
		keywords = { italic = true, bold = true },
		identifier = { italic = true, bold = true },
		storage_class = { italic = true },
	},
}

vim.cmd [[colorscheme tokyonight]]
