vim.opt.termguicolors = true

require('colorizer').setup {
	user_default_options = {
		filetypes = { '*' },
		mode = 'virtualtext',
	},
}
