local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

require('neo-tree').setup {
	{
		window = {
			position = 'right',
		},
		mappings = {
			['a'] = {
				'add',
				config = {
					show_path = 'relative',
				},
			},
		},
	},
}

map('n', '<leader>o', '<cmd>Neotree focus<CR>', opts)
map('n', '<leader>e', '<cmd>Neotree toggle<CR>', opts)
