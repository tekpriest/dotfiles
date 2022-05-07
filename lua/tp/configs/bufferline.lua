local bufferline = require("bufferline")

bufferline.setup({
	options = {
		numbers = "none",
		tab_size = 10,
		diagnostics = "nvim_lsp",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15,
		persist_buffer_sort = true,
		separator_style = "slant",
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		show_close_icon = true,
	},
	groups = {
		options = {
			toggle_hidden_on_enter = true,
		},
		items = {
			{
				name = "Tests",
				highlight = { gui = "underline", guisp = "black" },
				priority = 10,
				icon = "",
				matcher = function(buf)
					return buf.namr:match("%_test") or buf.name:match("%_spec") or buf.name:match("%.spec")
				end,
			},
		},
	},

	diagnostics_indicator = function(count, level, diagnostics_dict, context)
		local icon = level:match("error") and " " or " "
		return " " .. icon .. count
	end,
})
