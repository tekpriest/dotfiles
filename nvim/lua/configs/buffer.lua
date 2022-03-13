local bufferline = require("bufferline")

bufferline.setup({
	options = {
		numbers = "none",
		modified_icon = "•",
		tab_size = 10,
		diagnostics = "nvim_lsp",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15,
		persist_buffer_sort = true,
		separator_style = { "", "" },
		enforce_regular_tabs = false,
		always_show_bufferline = true,
	},
	highlights = {
		modified = {
			guifg = "#98c379",
			guibg = "#0F1E28",
		},
		modified_visible = {
			guifg = "#3C706F",
			guibg = "#16242E",
		},
		modified_selected = {
			guifg = "#62b3b2",
			guibg = "#142832",
		},
		fill = {
			guibg = "#0F1E28",
		},
		background = {
			guibg = "#0F1E28",
			guifg = "#a7adba",
		},
		tab = {
			guibg = "#0F1E28",
			guifg = "#343d46",
		},
		tab_selected = {
			guibg = "#142832",
		},
		tab_close = {
			guibg = "#0F1E28",
		},
		buffer_visible = {
			guibg = "#16242E",
		},
		buffer_selected = {
			guibg = "#142832",
			guifg = "#a5afbe",
			gui = "NONE",
		},
		indicator_selected = {
			guifg = "#62b3b2",
			guibg = "#142832",
		},
		separator = {
			guibg = "#62b3b2",
		},
		separator_selected = {
			guifg = "#62b3b2",
			guibg = "#142832",
		},
		separator_visible = {
			guibg = "#62b3b2",
		},
		duplicate = {
			guibg = "#0F1E28",
			guifg = "#a7adba",
			gui = "NONE",
		},
		duplicate_selected = {
			guibg = "#142832",
			gui = "NONE",
			guifg = "#a5afbe",
		},
		duplicate_visible = {
			guibg = "#16242E",
			gui = "NONE",
		},
	},
})
