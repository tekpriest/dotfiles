local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#D4D4D4", bg = "#303030", bold = false })
-- vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D7BA7D", bg = "#252525" })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D4D4D4", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#808080", bg = "#252525" })

local mode_color = {
	n = "#569cd6",
	i = "#6a9955",
	v = "#c586c0",
	[""] = "#c586c0",
	V = "#c586c0",
	c = "#4EC9B0",
	no = "#569cd6",
	s = "#ce9178",
	S = "#ce9178",
	[""] = "#ce9178",
	ic = "#dcdcaa",
	R = "#d16969",
	Rv = "#d16969",
	cv = "#569cd6",
	ce = "#569cd6",
	r = "#d16969",
	rm = "#4EC9B0",
	["r?"] = "#4EC9B0",
	["!"] = "#4EC9B0",
	t = "#D7BA7D",
}

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local mode = {
	function()
		return "▊"
	end,
	color = function()
		-- auto change color according to edit mode
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = 0,
}

local filename = {
	"filename",
	color = function()
		return { fg = mode_color[vim.fn.mode()] }
	end,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "%#SLGitIcon#" .. "" .. "%*" .. "%#SLBranchName#",
	-- color = "Constant",
	colored = true,
	gui = "bold",
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = {
		error = " ",
		warn = " ",
		info = " ",
		hint = " ",
	},
	colored = true,
	update_in_insert = true,
	always_visible = false,
}

local diff = {
	"diff",
	symbols = { added = " ", modified = "柳", removed = " " },
	diff_color = {
		added = { fg = "#a7c080" },
		modified = { fg = "#ffdf1b" },
		removed = { fg = "#ff6666" },
	},
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	icons_enabled = true,
}

lualine.setup({
	options = {
		globalstatus = true,
		focus_enabled = true,
		theme = "github_dark",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "terminal", "lazygit" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode, branch },
		lualine_b = { diagnostics },
		lualine_c = {
			function()
				return "%="
			end,
			filename,
		},
		lualine_x = { diff, filetype },
	},
})
