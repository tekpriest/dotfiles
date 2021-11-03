local api = vim.api

function _G.create_autogroups(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command("augroup " .. group_name)
		api.nvim_command("autocmd!")
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			api.nvim_command(command)
		end
		api.nvim_command("augroup END")
	end
end

local autocmds = {
	reload_config_files = {
		{ "BufWritePost", "*.lua", ":luafile %" },
	},
	restore_cursor = {
		{ "BufRead", "*", [[call setpos(".", getpos("'\""))]] },
	},
	resize_windows_horizontally = {
		{ "VimResized", "*", ":wincmd =" },
	},
	--  toggle_search_highlighting = {
	--  { 'InsertEnter', '*', 'setlocal nohlsearch'};
	-- };
	lua_highlight = {
		{ "TextYankPost", "*", "silent! lua vim.highlight.on_yank()" },
	},
	auto_syntax_on_enter = {
		{ "BufEnter", "*", ":syntax sync fromstart" },
	},
	auto_syntax_off_on_leave = {
		{ "BufLeave", "*", ":syntax sync clear" },
	},
	remove_trailing_whitespaces = {
		{ "BufWritePre", "*", [[%s/\s\+$//e"]] },
	},
	auto_format_for_prisma = {
		{ "BufWritePre", "*.prisma", ":Format" },
	},
	restore_cur = {
		{
			"BufReadPost",
			"*",
			[[ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif]],
		},
	},
	format_on_save = {
		{ "BufWritePre", "*", "undojoin | :Neoformat" },
	},
}

create_autogroups(autocmds)
