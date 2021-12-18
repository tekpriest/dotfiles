-- Options
local parsers = require("nvim-treesitter.parsers")
local Type = { GLOBAL_OPTION = "o", WINDOW_OPTION = "wo", BUFFER_OPTION = "bo" }
local add_options = function(option_type, options)
	if type(options) ~= "table" then
		error('options should be a type of "table"')
		return
	end
	local vim_option = vim[option_type]
	for key, value in pairs(options) do
		vim_option[key] = value
	end
end
local Option = {}
Option.g = function(options)
	add_options(Type.GLOBAL_OPTION, options)
end
Option.w = function(options)
	add_options(Type.WINDOW_OPTION, options)
end
Option.b = function(options)
	add_options(Type.BUFFER_OPTION, options)
end

Option.g({
	scrolloff = 4,
	sidescrolloff = 4,
	termguicolors = true,
	mouse = "a",
	clipboard = "unnamedplus",
	hidden = true,
	showmode = false,
	timeoutlen = 3e3,
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	conceallevel = 0,
	laststatus = 2,
	wrap = false,
	linebreak = true,
	list = true,
	listchars = "tab:»·,trail:·",
	wildmenu = true,
	wildmode = "full",
	wildignore = "*/cache/*,*/tmp/*,*/node_modules/*",
	autoread = true,
	updatetime = 500,
	redrawtime = 500,
	--fillchars = vim.o.fillchars .. "vert:│",
	undofile = true,
	virtualedit = "onemore",
	guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
	complete = ".,w,b,u,t,k",
	completeopt = "menu,menuone,noselect",
	formatoptions = "jtcroql",
	inccommand = "nosplit",
	shortmess = "atIcF",
	isfname = table.concat(
		vim.tbl_filter(function(entry)
			if entry == "=" then
				return false
			else
				return true
			end
		end, vim.split(vim.o.isfname, ",")),
		","
	),
	swapfile = false,
	diffopt = "internal,filler,closeoff,algorithm:patience,iwhiteall",
	splitbelow = true,
	emoji = false,
	indentexpr = "nvim_treesitter#indent()",
	showmatch = false,
	ignorecase = true,
	smartcase = true,
	title = true,
})
Option.b({
	swapfile = false,
	shiftwidth = 2,
	indentexpr = "nvim_treesitter#indent()",
})
Option.w({
	number = true,
	numberwidth = 1,
	signcolumn = "yes",
	spell = false,
	foldlevel = 99,
	foldmethod = "syntax",
	-- foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()",
	foldtext = "v:lua.foldText()",
	linebreak = true,
})
vim.g.clipboard = {
	name = "macOS-clipboard",
	copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
	paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
	cache_enabled = false,
}

vim.cmd('let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"')
vim.cmd('let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"')

vim.g.mapleader = " "
vim.g.one_allow_italics = true
vim.g.oceanic_next_terminal_bold = true
vim.g.oceanic_next_terminal_italic = true
vim.g.vim_monokai_tasty_italic = true
vim.g.table_mode_corner = "|"
vim.g.markdown_fold_override_foldtext = false
vim.g.markdown_syntax_conceal = false
vim.g.mkdp_auto_start = false
vim.g.vim_json_syntax_conceal = false
vim.g.override_nvim_web_devicons = true
local configs = parsers.get_parser_configs()
local ft_str = table.concat(
	vim.tbl_map(function(ft)
		return configs[ft].filetype or ft
	end, parsers.available_parsers()),
	","
)
vim.cmd("autocmd Filetype " .. ft_str .. " setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()")

vim.g.nvim_tree_quit_on_open = 1 -- 0 by default, closes the tree when you open a file
vim.g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_highlight_opened_files = 1 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
vim.g.nvim_tree_root_folder_modifier = ":~" -- This is the default. See :help filename-modifiers for more options
vim.g.nvim_tree_add_trailing = 1 -- 0 by default, append a trailing slash to folder names
vim.g.nvim_tree_group_empty = 1 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_disable_window_picker = 1 -- 0 by default, will disable the window picker.
vim.g.nvim_tree_icon_padding = " " --one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
vim.g.nvim_tree_symlink_arrow = " >> " -- defaults to ' ➛ '. used as a separator between symlinks' source and target.
vim.g.nvim_tree_respect_buf_cwd = 1 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
vim.g.nvim_tree_create_in_closed_folder = 0 -- 1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
vim.g.nvim_tree_refresh_wait = 500 -- 1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
vim.g.nvim_tree_window_picker_exclude = {
	filetype = { "notify", "packer", "qf" },
	buftype = { "terminal" },
}
-- Dictionary of buffer option names mapped to a list of option values that
-- indicates to the window picker that the buffer's window should not be selectable.
vim.g.nvim_tree_special_files = { "README.md", "Makefile", "MAKEFILE" } -- List of filenames that gets highlighted with NvimTreeSpecialFile
-- 1 by default, notice that if 'files' is 1, it will only display
vim.g.nvim_tree_show_icons = {
	git = true,
	folders = true,
	files = true,
	folder_arrows = true,
} -- If false, do not show the icons for one of 'git' 'folder' and 'files'
vim.g.nvim_tree_icons = {
	default = "",
	symlink = "",
	git = {
		unstaged = "✗",
		staged = "✓",
		unmerged = "",
		renamed = "➜",
		untracked = "★",
		deleted = "",
		ignored = "◌",
	},
	folder = {
		arrow_open = "",
		arrow_closed = "",
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "",
		symlink_open = "",
	},
}

vim.g.dashboard_default_executive = "telescope"

return Option
