local plugins = {
	"nvimtree",
	"autopairs",
	"neoscroll",
	"telescope",
	"indentline",
	"treesitter",
	"cmp",
	"lsp",
	"bufferline",
	"spectre",
	"lualine",
	"toggleterm",
	-- "tabnine",
	"symbols_outline",
	"gitsigns",
}

for k, v in ipairs(plugins) do
	local plugin = "tp.configs.plugins." .. v
	require(plugin)
end

require("Comment").setup({})
