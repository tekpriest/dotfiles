require 'tp.options'
require 'tp.keymaps'
require 'tp.autocmds'
require 'tp.lazy'

-- plugins
-- vim.pack.add {
-- 	{ src = 'https://github.com/stevearc/oil.nvim' },
-- 	{ src = 'https://github.com/echasnovski/mini.pick' },
-- 	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
-- }

-- require('mini.pick').setup()
-- require('oil').setup()

-- lsp
-- vim.lsp.enable { 'lua_ls', 'biome' }

vim.cmd [[colorscheme vague]]

-- misc
vim.cmd [[:hi StatusLine guibg=NONE]]
vim.cmd [[:hi StatusLineNC guibg=NONE]]
