local lualine = require("lualine")
local bufferline = require("bufferline")
local colors = require("kr.colors")

local function yanil_statusline() end
lualine.extensions = {
	function()
		_G.yanil_statusline = yanil_statusline
		vim.cmd([[autocmd! User  YanilTreeEnter setlocal statusline=%!v:lua.yanil_statusline()]])
	end,
}
lualine.setup({
	options = {
		theme = "gruvbox",
	},
	sections = {
		lualine_a = { "" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = { "b:gitsigns_status" },
		lualine_y = { "filetype" },
		lualine_z = {
			"location",
			{
				"diagnostics",
				sources = { "nvim_lsp" },
				symbols = { error = " ", warn = " ", info = " " },
			},
		},
	},
})

bufferline.setup({
	options = {
		view = "default",
		numbers = "ordinal",
		number_style = "",
		mappings = false,
		buffer_close_icon = "",
		modified_icon = "•",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15,
		show_buffer_close_icons = false,
		persist_buffer_sort = true,
		separator_style = { "", "" },
		enforce_regular_tabs = false,
		always_show_bufferline = true,
	},
	highlights = {
		modified = { guifg = colors.green, guibg = "#0F1E28" },
		modified_visible = { guifg = "#3C706F", guibg = "#16242E" },
		modified_selected = { guifg = colors.cyan, guibg = "#142832" },
		fill = { guibg = "#0F1E28" },
		background = { guibg = "#0F1E28", guifg = colors.base04 },
		tab = { guibg = "#0F1E28", guifg = colors.base01 },
		tab_selected = { guibg = "#142832" },
		tab_close = { guibg = "#0F1E28" },
		buffer_visible = { guibg = "#16242E" },
		buffer_selected = { guibg = "#142832", guifg = colors.white, gui = "NONE" },
		indicator_selected = { guifg = colors.cyan, guibg = "#142832" },
		separator = { guibg = "#62b3b2" },
		separator_selected = { guifg = colors.cyan, guibg = "#142832" },
		separator_visible = { guibg = colors.cyan },
		duplicate = { guibg = "#0F1E28", guifg = colors.base04, gui = "NONE" },
		duplicate_selected = { guibg = "#142832", gui = "NONE", guifg = colors.white },
		duplicate_visible = { guibg = "#16242E", gui = "NONE" },
	},
})
